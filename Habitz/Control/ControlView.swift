//
//  ControlView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                }
            HabitView()
                .tabItem{
                    Image(systemName: "hammer.fill")
                }
            SettingsView()
                .tabItem{
                    Image(systemName: "gearshape.fill")
                }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}
