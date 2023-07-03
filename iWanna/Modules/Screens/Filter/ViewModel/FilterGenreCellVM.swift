//
//  FilterGenreCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterGenreCellVM: TableViewCellModelProtocol {
    
    var buttonTapped: ((String) -> Void)?
    
    private let model: FilterGenreCell.Model
    
    init(model: FilterGenreCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterGenreCell) {
        cell.fill(from: model)
        cell.buttonTapped = buttonTapped
    }
}
