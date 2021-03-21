//
//  HabitButton.swift
//  Habitz
//
//  Created by Sam on 2021-03-20.
//

import Foundation
import SwiftUI


struct HabitButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .padding()
    }
}

struct NewHabitButton_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitButton()
    }
}
