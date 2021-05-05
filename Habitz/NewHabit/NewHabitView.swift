//
//  NewHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject var theme: Theme
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            NewHabitButton()
                .environmentObject(theme)
        }.frame(width: Dimensions.Width)
        .environmentObject(theme)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
