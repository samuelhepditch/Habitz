//
//  MutateHabit.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import Foundation
import SwiftUI

struct HabitUtils {
    @Environment(\.managedObjectContext) var moc
    
    func buildHabit(_ habit: Habit) {
        var built = false
        var index = 0
        while(!built){
            if habit.progress![index][1] == 0.5{
                habit.progress![index][1] = 1
                CoreDataManager.shared.save()
                built = true
            }else{
                index += 1
            }
        }
    }
    
    func undoHabit(_ habit: Habit) {
        var undone = false
        var index = habit.progress!.count - 1
        if (habit.progress![0][1] == 1.0) {
            while(!undone){
                if habit.progress![index][1] == 1.0{
                    habit.progress![index][1] = 0.5
                    CoreDataManager.shared.save()
                    undone = true
                }else{
                    index -= 1
                }
            }
        }
    }
    
    func categoryImage(_ category: String) -> Image {
        if category == "Diet" {
            return Image(systemName: "mouth")
        }else if category == "Fitness"{
            return Image(systemName: "lungs")
        }else if category == "Happiness"{
            return Image(systemName: "face.smiling")
        }else if category == "Productivity"{
            return Image(systemName: "checkmark.square")
        }else if category == "ColdTurkey"{
            return Image(systemName: "nosign")
        }else{
            return Image(systemName: "arrow.clockwise")
        }
    }
    
    func restartHabit(_ habit: Habit) {
        let arraySize = habit.progress!.count
        for i in 0..<arraySize {
          habit.progress![i][1] = 0.5
        }
    }

}
