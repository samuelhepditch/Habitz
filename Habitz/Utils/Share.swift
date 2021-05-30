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
        let url = URL(string: "https://apps.apple.com/us/app/habitz/id1566466964")

        let shareView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(shareView, animated: true, completion: nil)
    }
}
