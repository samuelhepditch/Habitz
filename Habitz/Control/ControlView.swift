//
//  ControlView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct ControlView: View {
    @StateObject var theme = Theme()
    let container = CoreDataManager.shared.container.viewContext
    @State private var selection = 0
    var body: some View {
        NavigationView {
            TabView(selection: $selection){
                HabitInsightView()
                    .tabItem{
                        Image(systemName: "person")
                        Text("Insights")
                    }
                    .environment(\.managedObjectContext, container)
                    .tag(0)
                HabitView()
                    .tabItem{
                        Image(systemName: "plus.app")
                        Text("Habits")
                    }
                    .environment(\.managedObjectContext, container)
                    .tag(1)
                SettingsView()
                    .tabItem{
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .environment(\.managedObjectContext, container)
                    .tag(2)
            }
        }
        .environmentObject(theme)
        .preferredColorScheme(theme.darkMode == true ? .dark : .light)
        .accentColor(theme.darkMode == true ? .white : .black)
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}
