//
//  UserDefaultsManager.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation

enum UserDefaultsKey: String {
    
    case seenTutorial
}

protocol UserDefaultsManagerInterface: AnyObject {
    
    func save<T: Any>(_ value: T, for key: UserDefaultsKey)
    func delete(_ key: UserDefaultsKey)
}

final class UserDefaultsManager: UserDefaultsManagerInterface {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func save<T>(_ value: T, for key: UserDefaultsKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func delete(_ key: UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
