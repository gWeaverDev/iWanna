//
//  UIView+Layout.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UIView {
    
    func addSubviewsWithoutAutorezing(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
