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
                                notesView(habit: habit)
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
    @State private var actionMenuActive: Bool  = false
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
            Button(action:{
                self.actionMenuActive = true
            }){
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .actionSheet(isPresented: $actionMenuActive, content: {
                let Restart = ActionSheet.Button.default(Text("Restart")){
                    self.mutateHabit.restartHabit(habit)
                    self.userInfo.objectWillChange.send()
                }
                let Delete = ActionSheet.Button.default(Text("Delete")){
                    self.mutateHabit.deleteHabit(self.userInfo,habit)
                    self.userInfo.objectWillChange.send()
                }
                let Cancel = ActionSheet.Button.default(Text("Cancel")){
                    self.actionMenuActive = false
                }
                return ActionSheet(title: Text("Action Menu").foregroundColor(.black), buttons: [Restart,Delete,Cancel])
            })
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
                self.mutateHabit.undoHabit(habit)
                self.userInfo.objectWillChange.send()
            }){
                Text("UNDO")
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .disabled(habit.Blocks[0][1] == 0.5 ? true : false)
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
}
}
//Mark: notesView **********************************************

    
struct notesView: View {
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.colorScheme) var colorScheme
    @State private var newNotes: String = ""
    var habit: Habit
    var body: some View {
        TextEditor(text: self.$newNotes)
            .frame(height: 150)
            .disableAutocorrection(true)
            .autocapitalization(.words)
            .padding()

        HStack{
            Spacer()
            Button(action:{
                hideKeyboard()
                self.habit.Notes = newNotes
                self.userInfo.objectWillChange.send()
            }){
                Text("SAVE")
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            Spacer()
        }
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
