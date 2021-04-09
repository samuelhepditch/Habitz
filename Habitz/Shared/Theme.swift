//
//  Theme.swift
//  Habitz
//
//  Created by Sam on 2021-04-08.
//

import Foundation
import SwiftUI
import Combine


class Theme: ObservableObject {
    @Published var darkMode = UserStorageUtil.getBool(UserStorageUtil.theme)
}
