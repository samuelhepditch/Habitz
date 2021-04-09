//
//  CreateHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct CreateHabitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Habit.entity(),sortDescriptors: []) var habit: FetchedResults<Habit>
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
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
        case Blue
        var id: String { self.rawValue }
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
                        .disableAutocorrection(true)
                    TextField("Motivation", text: self.$Motivation)
                        .disableAutocorrection(true)
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
                        Text("Blue").foregroundColor(.blue).tag(Colours.Blue)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                HStack{
                    Spacer()
                    Button(action:{
                        addHabit()
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Save")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }.edgesIgnoringSafeArea(.bottom)
                    Spacer()
                }
            }
        }
        
    }
    
    func addHabit(){
        let newHabit = Habit(context: self.moc)
        newHabit.name = self.Name
        newHabit.motivation = self.Motivation
        newHabit.category = self.Category.rawValue
        newHabit.colour = self.Colour.rawValue
        newHabit.blocks = self.blockBuilder(Int(self.Days)!)
        newHabit.notes = ""
        do {
            try self.moc.save()
        } catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    func blockBuilder(_ duration: Int) -> [[Double]]{
        var dayArray = [[Double]]()
        for i in 1...duration{
            dayArray.append([Double(i),0.5])
        }
        return dayArray
    }
}

struct CreateHabitView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitView()
    }
}

