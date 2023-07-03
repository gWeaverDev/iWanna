//
//  UICollectionReusableView+Reusable.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UICollectionReusableView {
    
    static var reuseIdentifier: String { String(describing: Self.self) }
    
    func cellAppearance() {
        backgroundColor = .clear
    }
}
