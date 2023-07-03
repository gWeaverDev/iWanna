//
//  BaseNavigationController.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        
        return .default
        
    }
}
