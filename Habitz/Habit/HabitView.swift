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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Habit.entity(),sortDescriptors: []) var habit: FetchedResults<Habit>
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(habit,id: \.self){ currentHabit in
                   ZStack{
                        Form {
                            Section {
                               titleView(habit: currentHabit)
                            }

                            Section{
                                Text("Progress")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                progressView(habit: currentHabit)
                                undoButtonView(habit: currentHabit)
                                buildButtonView(habit: currentHabit)
                            }
                            Section{
                                Text("Motivation")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                Text(currentHabit.wrappedMotivation)
                            }
                           Section{
                                Text("Notes")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            Section{
                                notesView(habit: currentHabit)
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
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    let mutateHabit = MutateHabit()
    
    var habit: Habit
    @State private var actionMenuActive: Bool  = false
    var body: some View{
        HStack{
            self.mutateHabit.categoryImage(habit.wrappedCategory)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Spacer()
            Text(habit.wrappedName)
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
                }
                let Delete = ActionSheet.Button.default(Text("Delete")){
                    self.moc.delete(habit)
                    try? moc.save()
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
    var habitColor: Color {
        if habit.wrappedColour == "System" {
            return Color.black
        }else if habit.wrappedColour == "Red"{
            return Color.red
        }else if habit.wrappedColour == "Orange"{
            return Color.orange
        }else if habit.wrappedColour == "Purple"{
            return Color.purple
        }else {
            return Color.blue
        }
    }
    
    var layout: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    var body: some View{
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(habit.wrappedBlocks, id: \.self){ day in
                ZStack{
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(habitColor)
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
    var body: some View {
        HStack{
            Spacer()
            Button(action:{
                self.mutateHabit.undoHabit(habit)
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

    var body: some View {
        HStack{
            Spacer()
            Button(action:{
                self.mutateHabit.buildHabit(habit)
                if habit.wrappedBlocks[habit.wrappedBlocks.count - 1][1] == 1 {
                    //habit built
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
                })
            }
            Spacer()
        }.padding(10)
}
}
//Mark: notesView **********************************************

    
struct notesView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @State private var newNotes: String = ""
    var habit: Habit
    var body: some View {
        TextEditor(text: self.$newNotes)
            .frame(height: 150)
            .disableAutocorrection(true)
            .autocapitalization(.words)
            .padding()
            .onAppear{
                self.newNotes = habit.wrappedNotes
            }

        HStack{
            Spacer()
            Button(action:{
                hideKeyboard()
                habit.notes = self.newNotes
                try? self.moc.save()
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
