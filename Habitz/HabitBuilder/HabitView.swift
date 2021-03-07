//
//  HabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI
import Combine

struct HabitView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(userInfo.HabitArray){ habit in
                    VStack{
                        HStack{
                            categoryImage(habit.Category)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(habit.Colour)
                                .padding(.leading,50)
                            Text(habit.Name)
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(habit.Colour)
                                .padding(.leading, 5)
                            Spacer()
                        }.offset(y: 20)
                         .padding()
                        Spacer()
                        progressView(habit: habit)
                        Text("\"\(habit.Motivation)\"")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(habit.Colour)
                            .padding()
                        Spacer()
                        buttonsView(habit: habit)
                    }
                }.frame(width: 400)
                NewHabitView()
            }
        }
    }

    
    func categoryImage(_ category: String) -> Image {
        if category == "Diet" {
            return Image(systemName: "mouth")
        }else if category == "Fitness"{
            return Image(systemName: "lungs")
        }else if category == "Mindfulness"{
            return Image(systemName: "face.smiling")
        }else if category == "Study"{
            return Image(systemName: "book")
        }else if category == "Productivity"{
            return Image(systemName: "lightbulb")
        }else{
            return Image(systemName: "arrow.clockwise")
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView()
    }
}


//Mark: progressView **********************************************

struct progressView: View {
    var habit: Habit
    var layout: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    var body: some View{
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(habit.Blocks, id: \.self){ day in
                ZStack{
                    Rectangle()
                        .border(Color.black)
                        .foregroundColor(habit.Colour)
                        .frame(width: 50, height: 50)
                        .opacity(day[1])
                    Text("\(Int(day[0]))")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            }
        }.padding()
    }
}


//Mark: buttonsView **********************************************

struct buttonsView: View {
    var habit: Habit
    @State private var alertShown = false
    let mutateHabit = MutateHabit()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        VStack {
            HStack{
                Button(action:{
                }){
                    Text("RESTART")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .border(Color.black)
                .background(habit.Colour)
                .padding()
                
                Button(action:{}){
                    Text("DELETE")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .border(Color.black)
                .background(habit.Colour)
                .padding()
            }
            
            Button(action:{
                self.mutateHabit.buildHabit(habit)
                self.userInfo.objectWillChange.send()
                if habit.Blocks[habit.Blocks.count - 1][1] == 1 {
                    self.alertShown = true
                }
            }){
                Text("BUILD")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .alert(isPresented: $alertShown) {
                Alert(title: Text("Congrats!\nYou built a new habit.").font(.title), message: Text(""), dismissButton: .default(Text("OK")))
            }
            .border(Color.black)
            .background(habit.Colour)
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}
