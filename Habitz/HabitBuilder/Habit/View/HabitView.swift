//
//  HabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI
import Combine


//Mark: HabitView  **********************************************

struct HabitView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(userInfo.HabitArray){ habit in
                    VStack{
                        titleView(habit: habit)
                        Spacer()
                        Divider()
                        Spacer()
                        progressView(habit: habit)
                        if habit.Motivation != "" {
                            Text("\"\(habit.Motivation)\"")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(habit.Colour)
                                .multilineTextAlignment(.center)
                                .padding()
                        }else{
                            Spacer()
                        }
                        Divider()
                        Spacer()
                        buttonsView(habit: habit)
                            .offset(y: -10)
                    }
                }.frame(width: 400)
                NewHabitView()
            }
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView()
    }
}

//Mark: titleView **********************************************

struct titleView: View {
    var habit: Habit
    let mutateHabit = MutateHabit()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View{
        HStack{
            self.mutateHabit.categoryImage(habit.Category)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(habit.Colour)
                .padding(.leading,50)
            Text(habit.Name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(habit.Colour)
                .padding(.leading, 5)
            Spacer()
        }.offset(y: 20)
        .padding()
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
    @State private var deleteAlertShown = false
    @State private var successAlertShown = false
    let mutateHabit = MutateHabit()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        VStack {
            HStack{
                Button(action:{
                    self.mutateHabit.restartHabit(habit)
                    self.userInfo.objectWillChange.send()
                }){
                    Text("RESTART")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
                .background(habit.Colour)
                .cornerRadius(20)
                .buttonStyle(StandardButtonStyle())
                .padding()
                
                Button(action:{
                    self.deleteAlertShown = true
                }){
                    Text("DELETE")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .alert(isPresented: $deleteAlertShown) {
                    Alert(
                        title: Text("Are you sure you want to delete this habit?"),
                        message: Text(""),
                        primaryButton: .destructive(Text("Delete")) {
                            self.mutateHabit.deleteHabit(self.userInfo,habit)
                            self.userInfo.objectWillChange.send()
                        },
                        secondaryButton: .cancel()
                    )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
                .background(habit.Colour)
                .cornerRadius(20)
                .buttonStyle(StandardButtonStyle())
                .padding()
            }
            
            Button(action:{
                self.mutateHabit.buildHabit(habit)
                self.userInfo.objectWillChange.send()
                if habit.Blocks[habit.Blocks.count - 1][1] == 1 {
                    self.successAlertShown = true
                }
            }){
                Text("BUILD")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
            }
            .alert(isPresented: $successAlertShown) {
                Alert(title: Text("Congrats!\nYou built a new habit.").font(.title), message: Text(""), dismissButton: .default(Text("OK")){
                    self.mutateHabit.restartHabit(habit)
                    self.userInfo.objectWillChange.send()
                })
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .background(habit.Colour)
            .cornerRadius(20)
            .buttonStyle(StandardButtonStyle())
            .frame(maxWidth: .infinity)
            .padding()
            
        }
    }
}
