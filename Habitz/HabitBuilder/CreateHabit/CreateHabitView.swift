//
//  CreateHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct CreateHabitView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State private var Name: String = ""
    @State private var Motivation: String = ""
    @State private var Category = Catergories.Diet
    @State private var Duration = Durations.One
    @State private var Colour = Colours.Red
    @EnvironmentObject var userInfo: UserInfo
    
    enum Durations: String, CaseIterable, Identifiable{
        case One
        case Two
        case Three
        case Four
        var id: String { self.rawValue }
    }
    
    enum Catergories: String, CaseIterable, Identifiable {
        case Diet
        case Fitness
        case Mindfulness
        case Study
        case Productivity
        case Routine
        var id: String { self.rawValue }
    }
    
    enum Colours: String, CaseIterable, Identifiable {
        case System
        case Red
        case Orange
        case Blue
        case Purple
        var id: String { self.rawValue }
    }
    
    
    var newHabit: Habit {
        Habit(Name: self.Name,Motivation: self.Motivation,Category: self.Category.rawValue,Blocks: arrayBuilder(self.Duration.rawValue),Colour: blockColour(self.Colour.rawValue))
    }
    var body: some View {
        VStack {
            Text("New Habit")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .offset(y: 20)
            
            Form {
                Section {
                    Text("Description")
                        .bold()
                }
                Section {
                    TextField("Name",text: self.$Name)
                    TextField("My Motivation (Optional)", text: self.$Motivation)
                }
                Section {
                    Text("Duration")
                        .bold()
                }
                Section {
                    Picker("",selection: self.$Duration){
                        Text("1 Week").tag(Durations.One)
                        Text("2 Weeks").tag(Durations.Two)
                        Text("3 Weeks").tag(Durations.Three)
                        Text("4 Weeks").tag(Durations.Four)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Category")
                        .bold()
                }
                Section {
                    Picker("", selection: self.$Category) {
                        Text("Diet").tag(Catergories.Diet)
                        Text("Fitness").tag(Catergories.Fitness)
                        Text("Mindfulness").tag(Catergories.Mindfulness)
                        Text("Study").tag(Catergories.Study)
                        Text("Productivity").tag(Catergories.Productivity)
                        Text("Routine").tag(Catergories.Routine)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Text("Color")
                        .bold()
                }
                
                Section {
                    Picker("", selection: $Colour) {
                        Text("System")
                            .tag(Colours.System)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Red")
                            .foregroundColor(.red)
                            .tag(Colours.Red)
                        Text("Orange")
                            .tag(Colours.Orange)
                            .foregroundColor(.orange)
                        Text("Blue")
                            .tag(Colours.Blue)
                            .foregroundColor(.blue)
                        Text("Purple")
                            .foregroundColor(.purple)
                            .tag(Colours.Purple)
                    }.pickerStyle(WheelPickerStyle())
                }
                
            }
        }
        
        Button(action:{
            userInfo.HabitArray.append(newHabit)
            self.presentationMode.wrappedValue.dismiss()
        }){
            Text("Save")
                .font(.title)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .fontWeight(.bold)
        }
    }
    
    func arrayBuilder(_ duration: String) -> [[Double]]{
        var days: Int
        var dayArray = [[Double]]()
        if duration == "One" {
            days = 7
        }else if duration == "Two"{
            days = 14
        }else if duration == "Three"{
            days = 21
        }else{
            days = 28
        }
        for i in 1...days{
            dayArray.append([Double(i),0.5])
        }
        return dayArray
    }
    

    func blockColour(_ colour: String) -> Color {
        if colour == "System"{
            return Color(colorScheme == .dark ? .gray : .black)
        }else if colour == "Red"{
            return Color(.red)
        }else if colour == "Orange" {
            return Color(.orange)
        }else if colour == "Blue" {
            return Color(.blue)
        }else{
            return Color(.purple)
        }
    }
}

struct CreateHabitView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitView()
    }
}
