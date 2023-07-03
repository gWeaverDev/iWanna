//
//  WishlistMovieCellVM.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

final class WishlistMovieCellVM: TableViewCellModelProtocol {
    
    var buttonActions: ((WishlistMovieCell.Actions) -> Void)?
    
    private let model: WishlistMovieCell.Model
    
    init(model: WishlistMovieCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: WishlistMovieCell) {
        cell.fill(with: model)
        cell.buttonAction = buttonActions
    }
}
