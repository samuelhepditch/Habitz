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
    @State private var soundFXEnabled: Bool = UserStorageUtil.getBool(UserStorageUtil.soundFX)
    
    var body: some View {
        VStack{
            List {
                Toggle("Dark Mode", isOn: self.$darkModeEnabled)
                    .onChange(of: self.darkModeEnabled) { enabled in
                        UserStorageUtil.store(enabled, key: UserStorageUtil.theme)
                        theme.darkMode = enabled
                    }
                Toggle("SoundFX", isOn: self.$soundFXEnabled)
                    .onChange(of: self.soundFXEnabled) { enabled in
                        UserStorageUtil.store(enabled, key: UserStorageUtil.soundFX)
                    }
            }
            Text("More updates coming soon.\nStay tuned! - Habitz team")
            .padding()
            .border(Color.red, width: 2)
            .padding()
            .offset(y: -Dimensions.Height / 2)
            
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
