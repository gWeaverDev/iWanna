//
//  DetailPosterCelVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import Foundation

final class DetailPosterCelVM: TableViewCellModelProtocol {
    
    private let model: DetailPosterCell.Model
    
    init(model: DetailPosterCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: DetailPosterCell) {
        cell.fill(from: model)
    }
}
