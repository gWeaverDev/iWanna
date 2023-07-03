//
//  DetailInfoCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import Foundation

final class DetailInfoCellVM: TableViewCellModelProtocol {
    
    var buttonAction: ((DetailInfoCell.Actions) -> Void)?
    
    private let model: DetailInfoCell.Model
    
    init(model: DetailInfoCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: DetailInfoCell) {
        cell.fill(from: model)
        cell.buttonAction = buttonAction
    }
}
