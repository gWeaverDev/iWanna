//
//  UICollectionView+Reusable.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UICollectionView {
    
    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
