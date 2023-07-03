//
//  UserDefaultsManager.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation

protocol UserDefaultsManagerProtocol: AnyObject {
    var apiToken: String { get set }
    var wishlistIDs: [Int] { get set }
    var isOnboardingCompleted: Bool { get set }
    func clearWishlist()
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    private enum UDKey: String {
        case wishlist
        case isOnboardingCompleted
        case apiToken
    }
    
    var apiToken: String {
        get { getValue(.apiToken) as? String ?? ""}
        set { setValue(newValue, key: .apiToken) }
    }
    
    var isOnboardingCompleted: Bool {
        get { getValue(.isOnboardingCompleted) as? Bool ?? false }
        set { setValue(newValue, key: .isOnboardingCompleted) }
    }
    
    var wishlistIDs: [Int] {
        get { getValue(.wishlist) as? [Int] ?? [] }
        set { setValue(newValue, key: .wishlist) }
    }
    
    private let suiteName = "iWannaUserDefaults"
    private lazy var userDefaults = UserDefaults(suiteName: suiteName)
    
    func clearWishlist() {
        wishlistIDs.removeAll()
    }
    
    private func setValue(_ value: Any?, key: UDKey) {
        userDefaults?.set(value, forKey: key.rawValue)
    }

    private func getValue(_ key: UDKey) -> Any? {
        return userDefaults?.value(forKey: key.rawValue)
    }
}
