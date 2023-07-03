//
//  FilterRatingCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterRatingCellVM: TableViewCellModelProtocol {
    
    var sliderValueChanged: ((String) -> Void)?
    
    private let model: FilterRatingCell.Model
    
    init(model: FilterRatingCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterRatingCell) {
        cell.fill(from: model)
        cell.sliderValueChanged = sliderValueChanged
    }
}
