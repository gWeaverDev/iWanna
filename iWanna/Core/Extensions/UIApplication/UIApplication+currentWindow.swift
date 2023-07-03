//
//  UIApplication+currentWindow.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

extension UIApplication {
    
    var currentWindow: UIWindow? {
        connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter { $0.isKeyWindow }.first
    }
}
