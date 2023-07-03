//
//  DetailDescriptionCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import Foundation

final class DetailDescriptionCellVM: TableViewCellModelProtocol {
    
    private let model: DetailDescriptionCell.Model
    
    init(model: DetailDescriptionCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: DetailDescriptionCell) {
        cell.fill(from: model)
    }
}
