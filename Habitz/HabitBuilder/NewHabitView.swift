//
//  NewHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Color(colorScheme == .dark ? .darkGray : .white)
                .edgesIgnoringSafeArea(.all)
            NewHabitButton()
        }.frame(width: 400)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
