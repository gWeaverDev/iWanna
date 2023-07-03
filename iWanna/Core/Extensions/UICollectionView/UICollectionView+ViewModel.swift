//
//  UICollectionView+ViewModel.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

extension UICollectionView {
    
    func registerCells(withModels models: AnyCollectionViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.viewClass)
        }
    }
    
    func dequeueReusableCell(withModel model: AnyCollectionViewCellModelProtocol, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }
    
}
