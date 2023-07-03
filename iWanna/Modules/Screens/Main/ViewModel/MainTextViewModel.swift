//
//  MainTextViewModel.swift
//  iWanna
//
//  Created by George Weaver on 29.06.2023.
//

import Foundation

final class MainTextViewModel: TableViewCellModelProtocol {
    
    private let model: MainTextCell.Model

    init(model: MainTextCell.Model) {
        self.model = model
    }

    func configure(_ cell: MainTextCell) {
        cell.fill(from: model)
    }
    
    
}
