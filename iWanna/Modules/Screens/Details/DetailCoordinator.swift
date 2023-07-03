//
//  DetailCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class DetailCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    
    var navigation: UINavigationController
    
    private let service: MainService
    private let movieID: Int
    
    init(navigation: UINavigationController, movieID: Int) {
        self.navigation = navigation
        let apiManager = APIManager()
        self.service = MainService(apiManager: apiManager)
        self.movieID = movieID
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .shareTapped(let movieName, let id):
            self.shareLink(with: movieName, and: id)
        default:
            break
        }
    }
    
    func start() {
        let model = DetailViewModelImpl(service: service, movieID: movieID)
        model.coordinator = self
        let controller = DetailVC(viewModel: model)
        makeSwipeGR(for: controller)
        navigation.pushViewController(controller, animated: true)
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
    
    private func shareLink(with name: String, and id: Int) {
        let textToShare = L10n.buttonShare() + " - " + name
        let currentURL = URL(string: "https://www.kinopoisk.ru/film/\(id)/")!
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, currentURL], applicationActivities: nil)
        
        navigation.present(activityViewController, animated: true, completion: nil)
    }
}
