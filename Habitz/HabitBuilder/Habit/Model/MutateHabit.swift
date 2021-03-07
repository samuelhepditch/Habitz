//
//  MutateHabit.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import Foundation
import SwiftUI

struct MutateHabit {
    
    func buildHabit(_ habit: Habit) {
        var built = false
        var index = 0
        while(!built){
            if habit.Blocks[index][1] == 0.5{
                habit.Blocks[index][1] = 1
                built = true
            }else{
                index += 1
            }
        }
    }
    
    func categoryImage(_ category: String) -> Image {
        if category == "Diet" {
            return Image(systemName: "mouth")
        }else if category == "Fitness"{
            return Image(systemName: "lungs")
        }else if category == "Mindfulness"{
            return Image(systemName: "face.smiling")
        }else if category == "Study"{
            return Image(systemName: "book")
        }else if category == "Productivity"{
            return Image(systemName: "lightbulb")
        }else{
            return Image(systemName: "arrow.clockwise")
        }
    }
    
    func restartHabit(_ habit: Habit) {
        let arraySize = habit.Blocks.count
        for i in 0..<arraySize {
            habit.Blocks[i][1] = 0.5
        }
    }
    
    func deleteHabit(_ habitArray: [Habit]) {
    }
}
