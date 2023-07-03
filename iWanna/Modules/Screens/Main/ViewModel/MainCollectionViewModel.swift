//
//  MainCollectionViewModel.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import Foundation

final class MainCollectionViewModel: TableViewCellModelProtocol {
    
    var cellTapped: (() -> Void)?
    
    private let model: MainCollectionCell.Model

    init(model: MainCollectionCell.Model) {
        self.model = model
    }

    func configure(_ cell: MainCollectionCell) {
        cell.fill(from: model)
        cell.cellTapped = cellTapped
    }
}
