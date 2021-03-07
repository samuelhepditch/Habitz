//
//  Habit.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import Foundation
import SwiftUI

class Habit: Identifiable, ObservableObject {
    var id = UUID()
    var Name = ""
    var Motivation = ""
    var Category = ""
    var Blocks = [[Double]]()
    var Colour = Color(.red)
    
    init(Name: String, Motivation: String, Category: String, Blocks: [[Double]], Colour: Color){
        self.Name = Name
        self.Motivation = Motivation
        self.Category = Category
        self.Blocks = Blocks
        self.Colour = Colour
    }
}
