//
//  FilterButtonCellVM.swift
//  iWanna
//
//  Created by George Weaver on 02.07.2023.
//

import UIKit

final class FilterButtonCellVM: TableViewCellModelProtocol {
    
    var buttonActions: ((FilterButtonCell.Actions) -> Void)?
    
    private let model: FilterButtonCell.Model
    
    init(model: FilterButtonCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterButtonCell) {
        cell.fill(from: model)
        cell.buttonActions = buttonActions
    }
}
