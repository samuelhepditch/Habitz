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
            if habit.wrappedBlocks[index][1] == 0.5{
                habit.blocks![index][1] = 1
                try? self.moc.save()
                built = true
            }else{
                index += 1
            }
        }
    }
    
    func undoHabit(_ habit: Habit) {
        var undone = false
        var index = habit.wrappedBlocks.count - 1
        if (habit.wrappedBlocks[0][1] == 1.0) {
            while(!undone){
                if habit.wrappedBlocks[index][1] == 1.0{
                    habit.blocks![index][1] = 0.5
                    try? self.moc.save()
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
        let arraySize = habit.wrappedBlocks.count
        for i in 0..<arraySize {
          habit.blocks![i][1] = 0.5
        }
    }

}
