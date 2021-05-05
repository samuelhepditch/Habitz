//
//  HabitInsightViewModel.swift
//  Habitz
//
//  Created by Sam on 2021-05-05.
//

import Foundation
import SwiftUI

class HabitInsightViewModel: ObservableObject {
    @Published var isInsightEntity = false

    static func calcPorportion(arr: [Int],index: Int) -> CGFloat {
        let workingSpace = Dimensions.Width * 0.8
        var sum = 0
        for i in arr { sum += i }
        return CGFloat((Double(arr[index]) / Double(sum))) * workingSpace
    }
}
