//
//  DetailViewModel.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

protocol DetailViewModel: AnyObject {
    func numberOfRows() -> Int
    func getData(_ completion: @escaping () -> Void)
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol
}

final class DetailViewModelImpl: DetailViewModel, Coordinating {
    
    var coordinator: Coordinator?
    var cellModels: [AnyTableViewCellModelProtocol] = []
    
    private let service: MainService
    private let userDefaults = UserDefaultsManager()
    private let movieID: Int
    
    init(service: MainService, movieID: Int) {
        let apiManager = APIManager()
        self.service = MainService(apiManager: apiManager)
        self.movieID = movieID
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func getData(_ completion: @escaping () -> Void) {
        cellModels.removeAll()
        
        getMovie(by: movieID) { [weak self] movie in
            let posterModel = DetailPosterCelVM(model: .init(posterImage: movie.poster?.url ?? ""))
            self?.cellModels.append(posterModel)
            
            let infoModel = DetailInfoCellVM(model:
                    .init(
                        id: movie.id,
                        movieName: movie.name ?? "",
                        rating: movie.rating?.kp ?? 0.0,
                        yearOfRelease: movie.year ?? 0,
                        genres: movie.genres.compactMap { $0.name },
                        countries: movie.countries.compactMap { $0.name }
                    )
            )
            infoModel.buttonAction = { [weak self] actions in
                switch actions {
                case .willWatch(let isTapped):
                    self?.addMovieToWishlist(by: self?.movieID ?? 0)
                case .share:
                    self?.shareTapped(with: movie.name ?? "", and: movie.id)
                }
            }
            self?.cellModels.append(infoModel)
            
            let descriptionModel = DetailDescriptionCellVM(model: .init(descriptionText: movie.description ?? ""))
            self?.cellModels.append(descriptionModel)
            
            completion()
        }
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
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
    
    private func addMovieToWishlist(by movieID: Int) {
        let movieIDs = userDefaults.wishlistIDs
        if !movieIDs.contains(movieID) {
            userDefaults.wishlistIDs.append(movieID)
        }
    }
    
    private func removeMoviewFromWishlist(by movieID: Int) {
        userDefaults.wishlistIDs.remove(at: movieID)
    }
    
    private func shareTapped(with movieName: String, and id: Int) {
        coordinator?.eventOccurred(with: .shareTapped(movieName, id))
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
