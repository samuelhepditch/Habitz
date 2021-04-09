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
            Toggle("Dark Mode", isOn: self.$darkModeEnabled)
                .onChange(of: self.darkModeEnabled) { enabled in
                    UserStorageUtil.store(enabled, key: UserStorageUtil.theme)
                    theme.darkMode = enabled
            }
            Button(action: ShareButton) {
                HStack{
                    Text("Share")
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(theme.darkMode ? .white : .black)
                }
            }
        }
        .navigationBarHidden(true)
        .font(.headline)
    }
    
    func ShareButton() {
        let shareView = UIActivityViewController(activityItems: ["Start building Habitz with me."], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(shareView, animated: true, completion: nil)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
