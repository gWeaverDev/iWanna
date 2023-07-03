//
//  WishlistActionCellVM.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

final class WishlistActionCellVM: TableViewCellModelProtocol {
    
    var buttonAction: ((WishlistActionCell.Actions) -> Void)?
    
    private let model: WishlistActionCell.Model
    
    init(model: WishlistActionCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: WishlistActionCell) {
        cell.fill(from: model)
        cell.buttonAction = buttonAction
    }
}
