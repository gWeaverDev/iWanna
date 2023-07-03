//
//  Core.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import Foundation

final class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.setValue(true, forKey: "isNewUser")
    }
}
