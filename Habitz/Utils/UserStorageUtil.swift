//
//  UserStorageUtil.swift
//  Habitz
//
//  Created by Sam on 2021-04-08.
//

import Foundation

class UserStorageUtil {
    
    static let theme = "theme"
    static let insightGenerated = "insightGen"
    static let soundFX = "soundFX"
    static let notifications = "notifications"
    
    static func store(_ item: Any, key: String) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(item, forKey: key)
    }

    static func getBool(_ key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        
        return userDefaults.bool(forKey: key)
    }
    
    static func get(_ key: String) -> Any? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key)
    }
    
    static func remove(_ key: String) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
    }
}
