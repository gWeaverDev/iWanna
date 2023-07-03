//
//  MovieCellViewModel.swift
//  iWanna
//
//  Created by George Weaver on 29.06.2023.
//

import Foundation

final class MovieCellViewModel: CollectionViewCellModelProtocol {
    
    var cellTapped: (() -> Void)?
    
    private let model: MovieCell.Model
    
    init(model: MovieCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: MovieCell) {
        cell.fill(from: model)
        cell.cellTapped = cellTapped
    }
}
