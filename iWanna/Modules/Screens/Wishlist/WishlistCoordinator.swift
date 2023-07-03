//
//  WishlistCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

final class WishlistCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    
    var navigation: UINavigationController
    private let service: MainService
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        let apiManager = APIManager()
        self.service = MainService(apiManager: apiManager)
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .wishlistMovieTapped(let movieID):
            let detailCoordinator = DetailCoordinator(navigation: navigation, movieID: movieID)
            childrenCoordinators.append(detailCoordinator)
            detailCoordinator.start()
        case .shareTapped(let movieName, let id):
            self.shareLink(with: movieName, and: id)
        default:
            break
        }
    }
    
    func start() {
        let model = WishlistViewModelImpl(service: service)
        model.coordinator = self
        let controller = WishlistVC(viewModel: model)
        makeSwipeGR(for: controller)
        navigation.pushViewController(controller, animated: true)
    }
    
    private func shareLink(with name: String, and id: Int) {
        let textToShare = L10n.buttonShare() + " - " + name
        let currentURL = URL(string: "https://www.kinopoisk.ru/film/\(id)/")!
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, currentURL], applicationActivities: nil)
        
        navigation.present(activityViewController, animated: true, completion: nil)
    }
    
    private func makeSwipeGR(for vc: UIViewController) {
        let swipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGestureRecognizer.edges = .left
        vc.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc private func handleSwipe(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            navigation.popViewController(animated: true)
        }
    }
    
}
