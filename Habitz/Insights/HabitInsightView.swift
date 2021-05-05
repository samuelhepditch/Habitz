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
                Section{
                    HStack {
                        Spacer()
                        Text("Habit Insights")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                }
                if viewModel.isInsightEntity == true {
                    Section{
                        HStack{
                            Text("Habits Built: ")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                            Text("\(insights[0].habitsBuilt!)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
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
                        CategoryGraphView(categoryArray: insights[0].categoryArray!)
                    }
                    
                    Section{
                        HStack{
                            Text("Total Habit Cycles: ")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                            Text("\(insights[0].totalCycles!)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear{
            if !UserStorageUtil.getBool(UserStorageUtil.notFirstLaunch) {
                UserStorageUtil.store(true, key: UserStorageUtil.notFirstLaunch)
                //MARK: create insights entity
                let newInsights = Insights(context: self.moc)
                newInsights.habitsBuilt = "0"
                newInsights.totalCycles = "0"
                newInsights.categoryArray = [0,0,0,0,0,0]
                print("----------------------------------")
                print("Habit Insights\n")
                print("----------------------------------")
                print("Habits Built: \(String(describing: newInsights.habitsBuilt!)) \n")
                print("Total Cycles: \(String(describing: newInsights.totalCycles!)) \n")
                print("Category Array: \(String(describing: newInsights.categoryArray!)) \n")
                print("----------------------------------")
                CoreDataManager.shared.save(){_ in
                    self.viewModel.isInsightEntity = true
                }
            }else{
                viewModel.isInsightEntity = true
            }
        }
        
    }
    
}


//MARK: category graph view

struct CategoryGraphView: View {
    
    var categoryArray: [Int]
    var body: some View {
        VStack(alignment: .leading){
            Group {
                Text("Diet: \(categoryArray[0])").font(.subheadline).fontWeight(.semibold)
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
            }
        }
    }
}
