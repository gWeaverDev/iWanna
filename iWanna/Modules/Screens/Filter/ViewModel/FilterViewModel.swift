//
//  FilterViewModel.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

protocol FilterViewModel: AnyObject {
    var reloadTableViewClosure: (() -> Void)? { get set }
    func numbersOfRow() -> Int
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol
    func getData(_ completion: @escaping () -> Void)
}

struct FiltersModel {
    var year: String?
    var rating: String?
    var genres: String?
    var countries: String?
}

final class FilterViewModelImpl: FilterViewModel, Coordinating {
    
    var coordinator: Coordinator?
    var reloadTableViewClosure: (() -> Void)?
    var cellModels: [AnyTableViewCellModelProtocol] = []
    
    private var filtersModel: FiltersModel = .init()
    
    func numbersOfRow() -> Int {
        return cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    func getData(_ completion: @escaping () -> Void) {
        cellModels.removeAll()
        
        let textModel = FilterTextCellVM(model: .init(titleText: L10n.filtersMainTitle()))
        cellModels.append(textModel)
        
        let yearModel = FilterYearCellVM(model: .init())
        yearModel.sliderValueChanged = { [weak self] sliderRange in
            self?.filtersModel.year = sliderRange
        }
        cellModels.append(yearModel)
        
        let countryModel = FilterCountryCelVM(model: .init())
        countryModel.buttonTapped = { [weak self] countries in
            self?.filtersModel.countries = countries
        }
        cellModels.append(countryModel)
        
        let genreModel = FilterGenreCellVM(model: .init())
        genreModel.buttonTapped = { [weak self] genres in
            self?.filtersModel.genres = genres
        }
        cellModels.append(genreModel)
        
        let ratingModel = FilterRatingCellVM(model: .init())
        ratingModel.sliderValueChanged = { [weak self] ratingRange in
            self?.filtersModel.rating = ratingRange
        }
        cellModels.append(ratingModel)
        
        let buttonsModel = FilterButtonCellVM(model: .init())
        buttonsModel.buttonActions = { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .showTapped:
                self.showMainVC(from: self.filtersModel)
            case .backTapped:
                self.setBack()
            }
        }
        cellModels.append(buttonsModel)
    }
    
    private func showMainVC(from model: FiltersModel) {
        coordinator?.eventOccurred(with: .filterShowTapped(model))
    }
    
    private func setBack() {
        coordinator?.eventOccurred(with: .filterBackTapped)
    }
}
