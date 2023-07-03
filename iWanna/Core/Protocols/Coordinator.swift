//
//  Coordinator.swift
//  iWanna
//
//  Created by George Weaver on 28.06.2023.
//

import UIKit

enum Event {
    case onboardingGetStartedTapped
    case mainWishlistTapped
    case mainFilterTapped
    case mainMovieTapped(_ movieID: Int)
    case wishlistMovieTapped(_ movieID: Int)
    case filterShowTapped(_ filterModel: FiltersModel)
    case filterBackTapped
    case shareTapped(_ movieName: String, _ id: Int)
}

protocol Coordinator {
    var childrenCoordinators: [Coordinator] { get set }
    var navigation: UINavigationController { get set }
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
