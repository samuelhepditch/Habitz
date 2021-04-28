//
//  CreateHabitViewModel.swift
//  Habitz
//
//  Created by Sam on 2021-04-27.
//

import Foundation
import SwiftUI

class createHabitViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Habit.entity(),sortDescriptors: [
        NSSortDescriptor(keyPath: \Habit.name, ascending: true)
    ]) var habit: FetchedResults<Habit>
    @Published var Name: String = ""
    @Published var Motivation: String = ""
    @Published var Category = Catergories.Diet
    @Published var Colour = Colours.System
    @Published var Days: String = ""
    @Published var errorMessage: String = ""
    
    enum Catergories: String, CaseIterable, Identifiable {
        case Diet
        case Fitness
        case Happiness
        case Productivity
        case ColdTurkey
        case Routine
        var id: String { self.rawValue }
    }
    
    
    enum Colours: String, CaseIterable, Identifiable {
        case System
        case Red
        case Orange
        case Purple
        case Blue
        var id: String { self.rawValue }
    }
    
    func addHabit(){
        let newHabit = Habit(context: self.moc)
        newHabit.name = Name
        newHabit.motivation = Motivation
        newHabit.category = Category.rawValue
        newHabit.colour = Colour.rawValue
        newHabit.blocks = self.blockBuilder(Int(Days)!)
        newHabit.notes = ""
        print("----------------------------------")
        print("Habit Information\n")
        print("----------------------------------")
        print("Name: \(String(describing: newHabit.name)) \n")
        print("Motivation: \(String(describing: newHabit.motivation)) \n")
        print("Category: \(String(describing: newHabit.category)) \n")
        print("Colour: \(String(describing: newHabit.colour)) \n")
        print("Blocks: \(String(describing: newHabit.blocks)) \n")
        print("Notes: \(String(describing: newHabit.notes)) \n")
        print("----------------------------------")
        try? moc.save()

    }
    func blockBuilder(_ duration: Int) -> [[Double]]{
        var dayArray = [[Double]]()
        for i in 1...duration{
            dayArray.append([Double(i),0.5])
        }
        return dayArray
    }
    
    func validEntry() -> Bool {
        if Name != "" && Motivation != ""  && Days != "" {
            if Int(Days)! < 100 {
                return true
            }else{
                errorMessage = "Please enter a value less than 100 into the \"Days\" field."
                return false
            }
        }
        errorMessage = "Please complete all the required fields."
        return false
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
