//
//  WishlistViewModel.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

protocol WishlistViewModel: AnyObject {
    var reloadTableViewClosure: (() -> Void)? { get set }
    func numbersOfRow() -> Int
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol
    func getData(_ completion: @escaping () -> Void)
}

final class WishlistViewModelImpl: WishlistViewModel, Coordinating {
    
    var coordinator: Coordinator?
    var reloadTableViewClosure: (() -> Void)?
    
    private var cellModels: [AnyTableViewCellModelProtocol] = []
    private let service: MainService
    private let userDefaults = UserDefaultsManager()
    
    init(service: MainService) {
        let apiManager = APIManager()
        self.service = MainService(apiManager: apiManager)
    }
    
    func numbersOfRow() -> Int {
        return cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    func getData(_ completion: @escaping () -> Void) {
        cellModels.removeAll()
        
        let actionModel = WishlistActionCellVM(model: .init())
        actionModel.buttonAction = { [weak self] actions in
            switch actions {
            case .clearAll:
                self?.shouldClearMovieCells()
            }
        }
        cellModels.append(actionModel)
        
        let wishlistMoviesIDs = userDefaults.wishlistIDs
        
        wishlistMoviesIDs.forEach { id in
            getMovie(by: id) { [weak self] movie in
                let movieModel = WishlistMovieCellVM(
                    model:
                            .init(
                                id: movie.id,
                                movieImage: movie.poster?.url ?? "",
                                movieName: movie.name ?? "",
                                rating: movie.rating?.kp ?? 0.0,
                                genres: movie.genres.compactMap { $0.name }
                            )
                )
                movieModel.buttonActions = { [weak self] actions in
                    switch actions {
                    case .share:
                        self?.shareTapped(with: movie.name ?? "", and: movie.id)
                    case .elementsTapped:
                        self?.showDetailVC(with: movie.id)
                    }
                }
                self?.cellModels.append(movieModel)
                completion()
            }
        }
    }
    
    private func getMovie(by id: Int, _ completion: @escaping (MovieDocs) -> Void) {
        service.getMovie(by: id) { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
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
    
    private func showDetailVC(with movieID: Int) {
        coordinator?.eventOccurred(with: .wishlistMovieTapped(movieID))
    }
    
    private func shareTapped(with movieName: String, and id: Int) {
        coordinator?.eventOccurred(with: .shareTapped(movieName, id))
    }
    
    private func shouldClearMovieCells() {
        self.userDefaults.clearWishlist()
        
        if userDefaults.wishlistIDs.isEmpty {
            cellModels.removeAll { $0 is WishlistMovieCellVM }
            reloadTableViewClosure?()
        }
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

