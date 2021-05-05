//
//  CreateHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct CreateHabitView: View {
    
    @EnvironmentObject var theme: Theme
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = createHabitViewModel()
    
    
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
                    TextField("Name",text: self.$viewModel.Name).disableAutocorrection(true)
                    TextField("Motivation", text: self.$viewModel.Motivation).disableAutocorrection(true)
                    TextField("Days",text: self.$viewModel.Days).disableAutocorrection(true)
                }
                Section {
                    Text("Category").bold()
                }
                Section {
                    Picker("", selection: self.$viewModel.Category) {
                        Text("Diet").tag(createHabitViewModel.Catergories.Diet)
                        Text("Fitness").tag(createHabitViewModel.Catergories.Fitness)
                        Text("Happiness").tag(createHabitViewModel.Catergories.Happiness)
                        Text("Productivity").tag(createHabitViewModel.Catergories.Productivity)
                        Text("Cold Turkey").tag(createHabitViewModel.Catergories.ColdTurkey)
                        Text("Routine").tag(createHabitViewModel.Catergories.Routine)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Text("Colors").bold()
                }
                Section {
                    Picker("", selection: self.$viewModel.Colour) {
                        Text("Green").foregroundColor(.green).tag(createHabitViewModel.Colours.Green)
                        Text("Red").foregroundColor(.red).tag(createHabitViewModel.Colours.Red)
                        Text("Orange").foregroundColor(.orange).tag(createHabitViewModel.Colours.Orange)
                        Text("Purple").foregroundColor(.purple).tag(createHabitViewModel.Colours.Purple)
                        Text("Blue").foregroundColor(.blue).tag(createHabitViewModel.Colours.Blue)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                if viewModel.errorMessage != "" {
                    Section {
                        Text(self.viewModel.errorMessage).font(.headline).foregroundColor(.red)
                    }
                }
                
                HStack{
                    Spacer()
                    Button(action:{
                        if viewModel.validEntry() {
                            addHabit()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }){
                        Text("Save")
                            .font(.title)
                            .foregroundColor(theme.darkMode == true ? .white : .black)
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }.edgesIgnoringSafeArea(.bottom)
                    Spacer()
                }
            }
        }
        .preferredColorScheme(theme.darkMode ? .dark : .light)
    }
    
    
    //MARK: required to be present in view in order to save data.
    
    func addHabit(){
        let newHabit = Habit(context: self.moc)
        newHabit.name = viewModel.Name
        newHabit.motivation = viewModel.Motivation
        newHabit.category = viewModel.Category.rawValue
        newHabit.colour = viewModel.Colour.rawValue
        newHabit.progress = self.viewModel.blockBuilder(Int(viewModel.Days)!)
        newHabit.notes = ""
        newHabit.cycles = "0"
        print("----------------------------------")
        print("Habit Information\n")
        print("----------------------------------")
        print("Name: \(String(describing: newHabit.name!)) \n")
        print("Motivation: \(String(describing: newHabit.motivation!)) \n")
        print("Category: \(String(describing: newHabit.category!)) \n")
        print("Colour: \(String(describing: newHabit.colour!)) \n")
        print("Blocks: \(String(describing: newHabit.progress!)) \n")
        print("Notes: \(String(describing: newHabit.notes!)) \n")
        print("----------------------------------")
        CoreDataManager.shared.save()

    }

}



