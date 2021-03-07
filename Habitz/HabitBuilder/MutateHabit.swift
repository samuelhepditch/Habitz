//
//  MutateHabit.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import Foundation

struct MutateHabit {
    func buildHabit(_ habit: Habit){
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
}
