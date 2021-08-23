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
                Text("\"Change might not be fast and it isn't always easy. But with time and effort, almost any habit can be reshaped.\"\n\n - Charles Duhigg")
                    .foregroundColor(Color.white)
                   .bold()
                   .italic()
                   .padding(40)
                   .background(
                      Capsule()
                        .fill(Color(.systemGray))
                        .frame(width: Dimensions.Width, height: 200, alignment: .center)
                   )
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
