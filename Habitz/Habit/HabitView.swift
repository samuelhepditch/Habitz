//
//  HabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI
import Combine

//MARK: HabitView

struct HabitView: View {
    
    @EnvironmentObject var theme: Theme
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.name, ascending: true)]
    ) var habit: FetchedResults<Habit>
    
    @State private var habitBuilt = false
    
    @State private var isRestartAlert = false
    
    var body: some View {
        ZStack{
            ScrollView(.horizontal) {
                HStack {
                    ForEach(habit,id: \.self){ currentHabit in
                        ZStack{
                            Form {
                                Section {
                                    titleView(habit: currentHabit)
                                }
                                Section{
                                    HStack{
                                        Text("Habit Cycles: ")
                                        Spacer()
                                        Text("\(currentHabit.cycles ?? "Unknown")")
                                    }
                                    .font(.headline)
                                }
                                Section{
                                    Text("Progress")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                Section{
                                    progressView(habit: currentHabit)
                                    restartButtonView(isRestartAlert: $isRestartAlert, habit: currentHabit)
                                    buildButtonView(habit: currentHabit, habitBuilt: $habitBuilt)
                                }
                                Section{
                                    Text("Motivation").font(.headline).fontWeight(.semibold)
                                }
                                Section{
                                    Text(currentHabit.motivation!)
                                }
                                Section{
                                    Text("Notes").font(.headline).fontWeight(.semibold)
                                }
                                Section{
                                    notesView(habit: currentHabit)
                                }
                            }
                            if isRestartAlert {
                                Color.secondary
                                restartAlertView(isRestartAlert: $isRestartAlert, habit: currentHabit)
                            }
                        }.frame(width: Dimensions.Width)
                    }
                    NewHabitView()
                        .environmentObject(theme)
                }
            }
            
            
            ForEach(1..<400, id: \.self){ _ in
                Confetti(animate: $habitBuilt)
            }
            if habitBuilt {
                Color.secondary
                habitBuiltView(habitBuilt: $habitBuilt)
            }
        }.navigationBarHidden(true)
    }
    
}
//MARK: titleView

struct titleView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    var habit: Habit
    @State private var actionMenuActive: Bool  = false
    var body: some View{
        HStack{
            HabitUtils.categoryImage(habit.category ?? "Unknown")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Dimensions.Width / 12, height: Dimensions.Width / 12)
            Spacer()
            Text(habit.name ?? "Unknown").fontWeight(.heavy)
            Spacer()
            Button(action:{
                self.actionMenuActive = true
            }){
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Dimensions.Width / 12, height: Dimensions.Width / 12)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .actionSheet(isPresented: $actionMenuActive, content: {
                let Restart = ActionSheet.Button.default(Text("Restart")){
                    HabitUtils.restartHabit(habit)
                }
                let Delete = ActionSheet.Button.default(Text("Delete")){
                    CoreDataManager.shared.delete(self.habit)
                }
                let Cancel = ActionSheet.Button.default(Text("Cancel")){
                    self.actionMenuActive = false
                }
                return ActionSheet(title: Text("Action Menu"), buttons: [Restart,Delete,Cancel])
            })
        }
    }
}

//MARK: progressView

struct progressView: View {
    @Environment(\.colorScheme) var colorScheme
    var habit: Habit
    var habitColor: Color {
        if habit.colour == "Green" {
            return Color.green
        }else if habit.colour == "Red"{
            return Color.red
        }else if habit.colour == "Orange"{
            return Color.orange
        }else if habit.colour == "Purple"{
            return Color.purple
        }else {
            return Color.blue
        }
    }
    
    var layout: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    var body: some View{
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(habit.progress!, id: \.self){ day in
                ZStack{
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(habitColor)
                        .frame(width: Dimensions.Width / 10, height: Dimensions.Width / 10)
                        .opacity(day[1])
                    Text("\(Int(day[0]))")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

//MARK: restartButtonView

struct restartButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isRestartAlert: Bool
    var habit: Habit
    @State private var deleteAlertShown = false
    @State private var successAlertShown = false
    
    let habitUtils = HabitUtils()
    var body: some View {
        HStack{
            Spacer()
            Button(action:{
                isRestartAlert = true
            }){
                Text("RESTART")
                    .fontWeight(.heavy)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            Spacer()
        }.padding(10)
    }
}

//MARK: Restart Alert View
struct restartAlertView: View {
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    @Environment(\.colorScheme) var colorScheme
    @Binding var isRestartAlert: Bool
    var habit: Habit
    var body: some View {
        VStack{
            Text("Are You Sure?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom,10)
            Text("Restarting a habit is considered a failure.")
                .font(.headline)
                .padding(.bottom, 20)
            Rectangle()
                .frame(width: Dimensions.Width / 1.5, height: 2)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Button(action:{
                HabitUtils.restartHabit(habit)
                insights[0].successArray![0] += 1
                CoreDataManager.shared.save()
                self.isRestartAlert = false
            }){
                Text("RESTART")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .padding(10)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(10)
    }
}


//MARK: Build Button View

struct buildButtonView: View {
    
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    
    @Environment(\.colorScheme) var colorScheme
    
    var habit: Habit
    
    @State private var deleteAlertShown = false
    
    @Binding var habitBuilt: Bool
    
    var body: some View {
        ZStack{
            HStack{
                Spacer()
                Button(action:{
                    HabitUtils.buildHabit(habit)
                    if habit.progress![habit.progress!.count - 1][1] == 1 {
                        insights[0].successArray![1] += 1
                        HabitUtils.restartHabit(habit)
                        if let cycles = habit.cycles {
                            if cycles == "0" {
                                insights[0].habitsBuilt = "\(Int(insights[0].habitsBuilt!)! + 1)"
                                switch habit.category {
                                case "Diet": insights[0].categoryArray![0] += 1
                                case "Fitness": insights[0].categoryArray![1] += 1
                                case "Happiness": insights[0].categoryArray![2] += 1
                                case "Productivity": insights[0].categoryArray![3] += 1
                                case "ColdTurkey": insights[0].categoryArray![4] += 1
                                default: insights[0].categoryArray![5] += 1  //Routine
                                }
                            }
                            insights[0].totalCycles = "\(Int(insights[0].totalCycles!)! + 1)"
                            habit.cycles = "\(Int(cycles)! + 1)"
                        }
                        CoreDataManager.shared.save()
                        self.habitBuilt = true
                    }
                }){
                    Text("BUILD")
                        .fontWeight(.heavy)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                Spacer()
            }.padding(10)
        }
    }
}


//MARK: habitBuiltView

struct habitBuiltView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var habitBuilt: Bool
    
    var body: some View {
        VStack{
            VStack{
                Text("🎉 Congratulations 🎉").font(.title).fontWeight(.semibold).padding(.bottom,20)
                Text("You built a new habit.").font(.headline).padding(.bottom, 5)
                Text("Keep it up!").font(.headline).padding(.bottom, 5)
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(30)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            
            HStack{
                Button(action:{
                    self.habitBuilt = false
                }){
                    Text("Exit").font(.headline).fontWeight(.semibold).foregroundColor(.red)
                }
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(10)
                .padding(.trailing, Dimensions.Width * 0.2)
                
                
                Button(action:{
                    Share.showActivityController()
                }){
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(10)
            }
        }
    }
}


//MARK: notesView

struct notesView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @State private var newNotes: String = ""
    var habit: Habit
    var body: some View {
        TextEditor(text: self.$newNotes)
            .frame(height: Dimensions.Height / 5)
            .disableAutocorrection(true)
            .autocapitalization(.words)
            .padding()
            .onAppear{
                self.newNotes = habit.notes ?? "Unknown"
            }
        
        HStack{
            Spacer()
            Button(action:{
                habit.notes = self.newNotes
                CoreDataManager.shared.save()
                hideKeyboard()
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

