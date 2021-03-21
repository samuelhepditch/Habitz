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
    @EnvironmentObject var userInfo: UserInfo
    
    @State private var Name: String = ""
    @State private var Motivation: String = ""
    @State private var Category = Catergories.Diet
    @State private var Colour = Colours.System
    @State private var Days: String = ""
    
    
    enum Catergories: String, CaseIterable, Identifiable {
        case Diet
        case Fitness
        case Happiness
        case Productivity
        case ColdTurkey
        case Routine
        var id: String { self.rawValue }
    }
    
    enum Colours: String, CaseIterable, Identifiable {
        case System
        case Red
        case Orange
        case Purple
        var id: String { self.rawValue }
    }
    
    
    var newHabit: Habit {
        Habit(Name: self.Name,Motivation: self.Motivation,Category: self.Category.rawValue,Blocks: arrayBuilder(Int(self.Days)!),Colour: blockColour(self.Colour.rawValue))
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
                    TextField("My Motivation", text: self.$Motivation)
                }
                Section {
                    Text("Duration")
                        .bold()
                }
                Section {
                    TextField("Days",text: self.$Days)
                }
                Section {
                    Text("Category")
                        .bold()
                }
                Section {
                    Picker("", selection: self.$Category) {
                        Text("Diet").tag(Catergories.Diet)
                        Text("Fitness").tag(Catergories.Fitness)
                        Text("Happiness").tag(Catergories.Happiness)
                        Text("Productivity").tag(Catergories.Productivity)
                        Text("Cold Turkey").tag(Catergories.ColdTurkey)
                        Text("Routine").tag(Catergories.Routine)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Text("Colors")
                        .bold()
                }
                Section {
                    Picker("", selection: self.$Colour) {
                        Text("System").tag(Colours.System)
                        Text("Red").foregroundColor(.red).tag(Colours.Red)
                        Text("Orange").foregroundColor(.orange).tag(Colours.Orange)
                        Text("Purple").foregroundColor(.purple).tag(Colours.Purple)
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
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    func arrayBuilder(_ duration: Int) -> [[Double]]{
        var dayArray = [[Double]]()
        for i in 1...duration{
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
