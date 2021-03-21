//
//  HabitArray.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import Foundation
import Combine

class UserInfo: ObservableObject {
    @Published var HabitArray = [Habit]()
    @Published var HabitsBuilt = 0
    @Published var HabitsFailed = 0
}
