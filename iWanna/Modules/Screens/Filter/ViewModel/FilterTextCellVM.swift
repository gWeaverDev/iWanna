//
//  FilterTextCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterTextCellVM: TableViewCellModelProtocol {
    
    private let model: FilterTextCell.Model
    
    init(model: FilterTextCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterTextCell) {
        cell.fill(from: model)
    }
}
