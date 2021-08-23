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
    @Published var Name: String = ""
    @Published var Motivation: String = ""
    @Published var Category = Catergories.Diet
    @Published var Colour = Colours.Green
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
        case Green
        case Red
        case Orange
        case Purple
        case Blue
        var id: String { self.rawValue }
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
            if !Days.isInt {
                errorMessage = "Enter a integer into \"Days\" field."
                return false
            }else if Int(Days)! >= 100 {
                errorMessage = "Enter a integer less than 100 into \"Days\" field."
                return false
            }else{
                return true
            }
        }
        errorMessage = "Complete all the required fields."
        return false
    }
}


extension String {
    var isInt: Bool {
            return Int(self) != nil
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
