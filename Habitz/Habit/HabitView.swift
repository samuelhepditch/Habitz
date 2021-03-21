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
                    ZStack{
                        Form {
                            Section {
                                titleView(habit: habit)
                            }
                            
                            Section{
                                Text("Progress")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                progressView(habit: habit)
                                undoButtonView(habit: habit)
                                buildButtonView(habit: habit)
                            }
                            Section{
                                Text("Motivation")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                Text(habit.Motivation)
                            }
                            Section{
                                Text("Notes")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                notesView()
                            }
                        }
                    }.frame(width: 410)
                }
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
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userInfo: UserInfo
    
    let mutateHabit = MutateHabit()
    
    var habit: Habit
    
    var body: some View{
        HStack{
            self.mutateHabit.categoryImage(habit.Category)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Spacer()
            Text(habit.Name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

//Mark: progressView **********************************************

struct progressView: View {
    @Environment(\.colorScheme) var colorScheme
    var habit: Habit
    var layout: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    var body: some View{
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(habit.Blocks, id: \.self){ day in
                ZStack{
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(habit.Colour)
                        .frame(width: 40, height: 40)
                        .opacity(day[1])
                    Text("\(Int(day[0]))")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

//Mark: undoButtonView **********************************************

struct undoButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    var habit: Habit
    @State private var deleteAlertShown = false
    @State private var successAlertShown = false
    let mutateHabit = MutateHabit()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        HStack{
            Spacer()
            Button(action:{
            }){
                Text("UNDO")
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            Spacer()
        }.padding(10)
    }
}

//Mark: buildButtonView **********************************************

struct buildButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    var habit: Habit
    @State private var deleteAlertShown = false
    @State private var successAlertShown = false
    let mutateHabit = MutateHabit()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        HStack{
            Spacer()
            Button(action:{
                self.mutateHabit.buildHabit(habit)
                self.userInfo.objectWillChange.send()
                if habit.Blocks[habit.Blocks.count - 1][1] == 1 {
                    self.userInfo.HabitsBuilt += 1
                    self.successAlertShown = true
                }
            }){
                Text("BUILD")
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .alert(isPresented: $successAlertShown) {
                Alert(title: Text("Congrats!\nYou built a new habit.").font(.title), message: Text(""), dismissButton: .default(Text("OK")){
                    self.mutateHabit.restartHabit(habit)
                    self.userInfo.objectWillChange.send()
                })
            }
            Spacer()
        }.padding(10)
        //                Button(action:{
        //                    if self.habit.Blocks[0][1] == 1 {
        //                        self.userInfo.HabitsFailed += 1
        //                    }
        //                    self.mutateHabit.restartHabit(habit)
        //                    self.userInfo.objectWillChange.send()
        //                }){
        //                    Image(systemName: "arrow.clockwise")
        //                        .resizable()
        //                        .aspectRatio(contentMode: .fit)
        //                        .frame(maxWidth: 50, maxHeight: 50)
        //                        .foregroundColor(HabitzColours.ButtonTextColour)
        //                }
        //                .overlay(
        //                    RoundedRectangle(cornerRadius: 20)
        //                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
        //                )
        //                .background(HabitzColours.ButtonColour)
        //                .cornerRadius(20)
        //                .buttonStyle(HabitButtonStyle())
        //                .padding()
        
        //                Button(action:{
        //                    if self.habit.Blocks[0][1] == 1 {
        //                        self.userInfo.HabitsFailed += 1
        //                    }
        //                    self.deleteAlertShown = true
        //                }){
        //                    Text("DELETE")
        //                        .font(.title)
        //                        .fontWeight(.heavy)
        //                        .foregroundColor(HabitzColours.ButtonTextColour)
        //                        .frame(maxWidth: .infinity, minHeight: 50)
        //                }
        //                .alert(isPresented: $deleteAlertShown) {
        //                    Alert(
        //                        title: Text("Are you sure you want to delete this habit?"),
        //                        message: Text(""),
        //                        primaryButton: .destructive(Text("Delete")) {
        //                            self.mutateHabit.deleteHabit(self.userInfo,habit)
        //                            self.userInfo.objectWillChange.send()
        //                        },
        //                        secondaryButton: .cancel()
        //                    )
        //                }
        //                .overlay(
        //                    RoundedRectangle(cornerRadius: 20)
        //                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
        //                )
        //                .background(HabitzColours.ButtonColour)
        //                .cornerRadius(20)
        //                .buttonStyle(HabitButtonStyle())
        //                .padding()
    }
}

//Mark: notesView **********************************************


struct notesView: View {
    var body: some View {
        Text("Current Placeholder")
    }
}
