//
//  CreateHabitView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct CreateHabitView: View {
    
    @EnvironmentObject var theme: Theme
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
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
                    TextField("Name",text: self.$viewModel.Name)
                        .disableAutocorrection(true)
                    TextField("Motivation", text: self.$viewModel.Motivation)
                        .disableAutocorrection(true)
                    TextField("Days",text: self.$viewModel.Days)
                        .keyboardType(.numberPad)
                }
                Section {
                    Text("Category")
                        .bold()
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
                    Text("Colors")
                        .bold()
                }
                Section {
                    Picker("", selection: self.$viewModel.Colour) {
                        Text("System").tag(createHabitViewModel.Colours.System)
                        Text("Red").foregroundColor(.red).tag(createHabitViewModel.Colours.Red)
                        Text("Orange").foregroundColor(.orange).tag(createHabitViewModel.Colours.Orange)
                        Text("Purple").foregroundColor(.purple).tag(createHabitViewModel.Colours.Purple)
                        Text("Blue").foregroundColor(.blue).tag(createHabitViewModel.Colours.Blue)
                    }.pickerStyle(WheelPickerStyle())
                }
                
                if viewModel.errorMessage != "" {
                    Section {
                        Text(self.viewModel.errorMessage)
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
                
                HStack{
                    Spacer()
                    Button(action:{
                        if viewModel.validEntry() {
                            viewModel.addHabit()
                            self.presentationMode.wrappedValue.dismiss()
                        }
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
        .preferredColorScheme(theme.darkMode ? .dark : .light)
    }
}


