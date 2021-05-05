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
    var body: some View {
        NavigationView {
            TabView {
                HabitInsightView()
                    .tabItem{
                        Image(systemName: "person")
                        Text("Insights")
                    }
                    .environment(\.managedObjectContext, container)
                HabitView()
                    .tabItem{
                        Image(systemName: "plus.app")
                        Text("Habits")
                    }
                    .environment(\.managedObjectContext, container)
                SettingsView()
                    .tabItem{
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .environment(\.managedObjectContext, container)
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
