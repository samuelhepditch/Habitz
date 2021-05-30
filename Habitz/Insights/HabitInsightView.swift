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
                    SuccessRatioGraph(successRatioArray: viewModel.showPremiumFeature ? insights[0].successArray! : [0,0])
                }
                
                Section{
                    HStack{
                        Text("Habits Built: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                        if viewModel.showPremiumFeature{
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
                
                Section {
                    HStack{
                        Text("Habits Built By Category ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                    CategoryGraph(categoryArray: viewModel.showPremiumFeature ? insights[0].categoryArray! : [0,0,0,0,0,0])
                }
                
                Section{
                    HStack{
                        Text("Total Habit Cycles: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                        if viewModel.showPremiumFeature {
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
                
            }
            .navigationBarHidden(true)
            
            if viewModel.showPremiumFeature == false {
                Color.secondary
                GoPremiumView(showPremiumFeature: $viewModel.showPremiumFeature)
            }
        }
        .onAppear{
            if UserStorageUtil.getBool(UserStorageUtil.isPremiumMember) == true {
                viewModel.showPremiumFeature = true
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


//MARK: GoPremiumView

struct GoPremiumView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    @Environment(\.colorScheme) var colorScheme
    @Binding var showPremiumFeature: Bool
    var body: some View {
        VStack{
            VStack {
                Text("Insights that hold you accountable!")
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.bottom,10)
                
                Divider()
                Button(action:{
                    PurchaseService.purchase(productID: "insight"){
                        generateInsightEntity(){
                            showPremiumFeature = true
                            UserStorageUtil.store(true, key: UserStorageUtil.isPremiumMember)
                        }
                    }
                }){
                    VStack{
                        Text("Go Premium 🔓")
                            .font(.headline)
                    }
                }
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(10)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
            .frame(width: Dimensions.Width * 0.8)
            VStack {
                Text("*Previous purchases restored free of charge*")
                    .font(.subheadline)
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(10)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
            .frame(width: Dimensions.Width * 0.8)
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
