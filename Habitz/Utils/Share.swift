//
//  Share.swift
//  Habitz
//
//  Created by Sam on 2021-05-04.
//

import Foundation
import SwiftUI

class Share {
    static func showActivityController(){
        let shareView = UIActivityViewController(activityItems: ["Start building Habitz with me."], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(shareView, animated: true, completion: nil)
    }
}
