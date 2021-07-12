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
            VStack{
                Spacer()
                Text("\"Change might not be fast and it isn't always easy. But with time and effort, almost any habit can be reshaped.\"")
                   .bold()
                   .italic()
                   .padding(40)
                Text("- Charles Duhigg")
                   .bold()
                   .italic()
                Spacer()
                NewHabitButton()
                .environmentObject(theme)
                Spacer()
            }
        }.frame(width: Dimensions.Width)
        .environmentObject(theme)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
