//
//  MainViewModel.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import Foundation

protocol MainViewModel: AnyObject {
    func numberOfRows() -> Int
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol
    func getMovies(with limit: Int, from filtersModel: FiltersModel, _ completion: @escaping ([MovieDocs]) -> Void)
    func getData(_ completion: @escaping() -> Void)
}

final class MainViewModelImp: MainViewModel, Coordinating {
    
    var coordinator: Coordinator?
    var cellModels: [AnyTableViewCellModelProtocol] = []
    
    private let service: MainServiceProtocol
    private var filtersModel: FiltersModel {
        didSet {
            cellModels.removeAll { $0 is MainActionCellViewModel }
        }
    }
    
    init(filtersModel: FiltersModel) {
        let apiManager = APIManager()
        self.service = MainService(apiManager: apiManager)
        self.filtersModel = filtersModel
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    func getData(_ completion: @escaping () -> Void) {
        cellModels.removeAll()
        
        let actionModel = MainActionCellViewModel(model: .init())
        actionModel.buttonAction = { [weak self] actions in
            switch actions {
            case .filterTapped:
                self?.showFiltersVC()
            case .wishlistTapped:
                self?.showWishlistVC()
            }
        }
        
        let textModel = MainTextViewModel(model: .init(title: L10n.mainTitle()))
        
        cellModels.append(actionModel)
        cellModels.append(textModel)
        
        getMovies(from: filtersModel) { [weak self] movies in
            var arrayOfMovies: [MovieCellViewModel] = []
            
            movies.forEach { movie in
                
                let movieModel = MovieCellViewModel(
                    model: .init(
                        id: movie.id,
                        posterImage: movie.poster?.url ?? "",
                        movieName: movie.name ?? ""
                    )
                )
                movieModel.cellTapped = {
                    self?.showDetailVC(by: movie.id)
                }
                arrayOfMovies.append(movieModel)
            }
            
            let mainCollectionModel = MainCollectionViewModel(model: .init(dataItems: arrayOfMovies))
            self?.cellModels.append(mainCollectionModel)

            completion()
        }
    }
    
    func getMovies(
        with limit: Int = 30,
        from filtersModel: FiltersModel,
        _ completion: @escaping ([MovieDocs]) -> Void
    ) {
        
        service.getMovies(
            request: .init(
                limit: limit,
                yearRange: filtersModel.year ?? "1965-2023",
                ratingRange: filtersModel.rating ?? "0.0-10.0",
                genres: filtersModel.genres ?? "",
                countries: filtersModel.countries ?? ""
            )
        ) { [weak self] result in
            switch result {
            case .success(let data):
                completion(data.docs)
            case .failure(let error):
                self?.showAlert(
                    title: L10n.networkErrorApiFailmap(),
                    description: "\n\n\(error.localizedDescription)",
                    buttonTitle: L10n.commonOk(),
                    buttonCallback: nil
                )
            }
        }
    }
    
    private func showFiltersVC() {
        coordinator?.eventOccurred(with: .mainFilterTapped)
    }
    
    private func showWishlistVC() {
        coordinator?.eventOccurred(with: .mainWishlistTapped)
    }
    
    private func showDetailVC(by movieID: Int) {
        coordinator?.eventOccurred(with: .mainMovieTapped(movieID))
    }
    
    private func showAlert(title: String, description: String, buttonTitle: String, buttonCallback: (() -> Void)?) {
        let alert = AttributedTextButtonAlert()
        alert.setTitleOrAndDescription(title: title, description: description)
        alert.setButtonTitle(text: buttonTitle)
        alert.setButtonCallBack(callback: buttonCallback)
        alert.setupCloseByTap()
        AlertManager.shared.addAlertView(alert)
    }
}
