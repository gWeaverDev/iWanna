//
//  FilterCountryCelVM.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterCountryCelVM: TableViewCellModelProtocol {
    
    var buttonTapped: ((String) -> Void)?
    
    private let model: FilterCountryCell.Model
    
    init(model: FilterCountryCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FilterCountryCell) {
        cell.fill(from: model)
        cell.buttonTapped = buttonTapped
    }
}
