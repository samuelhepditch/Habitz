//
//  NewHabitButton.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct NewHabitButton: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.colorScheme) var colorScheme
    @State private var CreateHabitViewActive: Bool = false
    var body: some View {
        VStack{
            Button(action:{
                CreateHabitViewActive.toggle()
            }){
                VStack{
                    Image(systemName: "plus.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    Text("New Habit")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            .buttonStyle(HabitButtonStyle())
            .sheet(isPresented: $CreateHabitViewActive){
                CreateHabitView()
                    .environmentObject(theme)
            }
        }
    }
    
}


