//
//  MainActionCellViewModel.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import Foundation

final class MainActionCellViewModel: TableViewCellModelProtocol {
    
    var buttonAction: ((MainActionCell.Actions) -> Void)?
    
    private let model: MainActionCell.Model

    init(model: MainActionCell.Model) {
        self.model = model
    }

    func configure(_ cell: MainActionCell) {
        cell.fill(from: model)
        cell.buttonAction = buttonAction
    }
}
