//
//  InsightView.swift
//  Habitz
//
//  Created by Sam on 2021-03-20.
//

import SwiftUI
import Combine

struct HabitInsightView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var resetViewActive = false
    
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    
    @StateObject var viewModel = HabitInsightViewModel()
    
    var body: some View {
        ZStack{
            Form {
                Section {
                    HStack{
                        Spacer()
                        Text("Habit Insights")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                Section {
                    Text("Success Ratio")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    SuccessRatioGraph(successRatioArray: UserStorageUtil.getBool(UserStorageUtil.insightGenerated) ? insights[0].successArray! : [0,0])
                }
                
                Section{
                    HStack{
                        Text("Habits Built: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                        if UserStorageUtil.getBool(UserStorageUtil.insightGenerated) {
                            Text("\(insights[0].habitsBuilt!)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }else{
                            Text("0")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
                
                Section{
                    HStack{
                        Text("Total Habit Cycles: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                        if UserStorageUtil.getBool(UserStorageUtil.insightGenerated) {
                            Text("\(insights[0].totalCycles!)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }else {
                            Text("0")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }

                
                Section {
                    HStack{
                        Text("Habits Built By Category ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                    CategoryGraph(categoryArray: UserStorageUtil.getBool(UserStorageUtil.insightGenerated) ? insights[0].categoryArray! : [0,0,0,0,0,0])
                }
                                
                Section {
                    HStack{
                        Spacer()
                        Button(action: {
                            resetViewActive = true 
                        }){
                            Text("RESET")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
            if resetViewActive {
                Color.secondary
                ResetView(resetViewActive: $resetViewActive).padding()
            }
        }.onAppear(){
            if (!UserStorageUtil.getBool(UserStorageUtil.insightGenerated)) {
              generateInsightEntity() {
                  UserStorageUtil.store(true, key: UserStorageUtil.insightGenerated)
              }
            }
            viewModel.update.toggle();
        }
        
    }
    
    func generateInsightEntity(completion: @escaping () -> Void){
        //MARK: create insights entity
        let newInsights = Insights(context: self.moc)
        newInsights.habitsBuilt = "0"
        newInsights.totalCycles = "0"
        newInsights.categoryArray = [0,0,0,0,0,0]
        newInsights.successArray = [0,0]
        print("----------------------------------")
        print("Habit Insights\n")
        print("----------------------------------")
        print("Habits Built: \(String(describing: newInsights.habitsBuilt!)) \n")
        print("Total Cycles: \(String(describing: newInsights.totalCycles!)) \n")
        print("Category Array: \(String(describing: newInsights.categoryArray!)) \n")
        print("Success Array: \(String(describing: newInsights.successArray!)) \n")
        print("----------------------------------")
        CoreDataManager.shared.save(){ _ in
            completion()
        }
    }
}


//MARK: ResetView

struct ResetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var resetViewActive: Bool
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.name, ascending: true)]
    ) var habit: FetchedResults<Habit>
    var body: some View {
        VStack{
            VStack {
                Text("Are You Sure?")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom,10)
                Text("Resetting insights will return all recorded data to zero.")
                    .font(.headline)
                    .padding(.bottom, 20)
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(10)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            HStack {
                Button(action:{
                    resetViewActive = false;
                }){
                    Text("CANCEL")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .frame(width: 100, height: 60)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(10)
                .padding(.trailing, Dimensions.Width * 0.2)
                
                Button(action:{
                    insights[0].habitsBuilt = "0"
                    insights[0].totalCycles = "0"
                    insights[0].categoryArray = [0,0,0,0,0,0]
                    insights[0].successArray = [0,0]
                    CoreDataManager.shared.save()
                    for item in habit {
                        item.cycles = "0";
                        CoreDataManager.shared.save()
                    }
                    resetViewActive = false;
                }){
                    Text("RESET")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(width: 100, height: 60)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(10)
            }
        }
    }
}


//MARK: Category Graph

struct CategoryGraph: View {
    
    var categoryArray: [Int]
    var body: some View {
        VStack(alignment: .leading){
            Group {
                Text("Diet: \(categoryArray[0])").font(.subheadline).fontWeight(.semibold).padding(.top, 5)
                Rectangle()
                    .frame(width: categoryArray[0] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 0), height: Dimensions.Height / 75)
                    .foregroundColor(.red)
            }
            Group{
                Text("Fitness: \(categoryArray[1])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: categoryArray[1] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 1), height: Dimensions.Height / 75)
                    .foregroundColor(.orange)
            }
            Group{
                Text("Happiness: \(categoryArray[2])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: categoryArray[2] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 2), height: Dimensions.Height / 75)
                    .foregroundColor(.green)
            }
            Group{
                Text("Productivity: \(categoryArray[3])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: categoryArray[3] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 3), height: Dimensions.Height / 75)
                    .foregroundColor(.blue)
            }
            Group{
                Text("Cold Turkey: \(categoryArray[4])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: categoryArray[4] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 4), height: Dimensions.Height / 75)
                    .foregroundColor(.purple)
            }
            Group{
                Text("Routine: \(categoryArray[5])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: categoryArray[5] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: categoryArray, index: 5), height: Dimensions.Height / 75)
                    .foregroundColor(.yellow)
                    .padding(.bottom, 5)
            }
        }
    }
}



//MARK: Success Ratio Graph

struct SuccessRatioGraph: View {
    
    var successRatioArray: [Int]
    
    var body: some View {
        VStack(alignment: .leading){
            Group {
                Text("Failures: \(successRatioArray[0])").font(.subheadline).fontWeight(.semibold).padding(.top, 5)
                Rectangle()
                    .frame(width: successRatioArray[0] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: successRatioArray, index: 0), height: Dimensions.Height / 75)
                    .foregroundColor(.red)
            }
            Group{
                Text("Successes: \(successRatioArray[1])").font(.subheadline).fontWeight(.semibold)
                Rectangle()
                    .frame(width: successRatioArray[1] == 0 ? 20 : HabitInsightViewModel.calcPorportion(arr: successRatioArray, index: 1), height: Dimensions.Height / 75)
                    .foregroundColor(.green)
                    .padding(.bottom, 5)
            }
        }
    }
}
    

