//
//  SettingsView.swift
//  Habitz
//
//  Created by Sam on 2021-03-07.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theme: Theme
    @State private var darkModeEnabled: Bool = UserStorageUtil.getBool(UserStorageUtil.theme)
    var body: some View {
        List {
            Toggle("Dark Mode  🌙", isOn: self.$darkModeEnabled)
                .onChange(of: self.darkModeEnabled) { enabled in
                    UserStorageUtil.store(enabled, key: UserStorageUtil.theme)
                    theme.darkMode = enabled
            }
        }
        .navigationBarHidden(true)
        .font(.headline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
