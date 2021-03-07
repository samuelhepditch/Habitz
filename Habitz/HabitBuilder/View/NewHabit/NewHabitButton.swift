//
//  NewHabitButton.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct NewHabitButton: View {
    @State private var CreateHabitViewActive: Bool = false
    var body: some View {
            Button(action:{
                CreateHabitViewActive.toggle()
            }){
                VStack{
                    Image(systemName: "plus.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.black)
                    Text("New Habit")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(StandardButtonStyle())
            .sheet(isPresented: $CreateHabitViewActive){
                CreateHabitView()
            }
        }
}

struct StandardButtonStyle: ButtonStyle {
    
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
