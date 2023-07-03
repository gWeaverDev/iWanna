//
//  MainCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 28.06.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    var filtersModel: FiltersModel?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .mainFilterTapped:
            let filterCoordinator = FilterCoordinator(navigation: navigation)
            childrenCoordinators.append(filterCoordinator)
            filterCoordinator.start()
        case .mainWishlistTapped:
            let wishlistCoordinator = WishlistCoordinator(navigation: navigation)
            childrenCoordinators.append(wishlistCoordinator)
            wishlistCoordinator.start()
        case .mainMovieTapped(let movieID):
            let detailCoordinator = DetailCoordinator(navigation: navigation, movieID: movieID)
            childrenCoordinators.append(detailCoordinator)
            detailCoordinator.start()
        default:
            break
        }
    }
    
    func start() {
        let model = MainViewModelImp(filtersModel: filtersModel ?? .init())
        model.coordinator = self
        let controller = MainVC(viewModel: model)
        navigation.setViewControllers([controller], animated: true)
    }
}
