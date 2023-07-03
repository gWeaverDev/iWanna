//
//  FilterYearCellVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterYearCellVM: TableViewCellModelProtocol {
    
    var sliderValueChanged: ((String) -> Void)?
    
    private let model: FilterYearCell.Model
    
    init(model: FilterYearCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterYearCell) {
        cell.fill(from: model)
        cell.sliderValueChanged = sliderValueChanged
    }
}
