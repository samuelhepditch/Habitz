//
//  ControlView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct ControlView: View {
    @StateObject var theme = Theme()
    var body: some View {
        NavigationView {
            TabView {
                InsightView()
                    .tabItem{
                        Image(systemName: "person")
                        Text("Insights")
                    }
                HabitView()
                    .tabItem{
                        Image(systemName: "plus.app")
                        Text("Habits")
                    }
                SettingsView()
                    .tabItem{
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
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
