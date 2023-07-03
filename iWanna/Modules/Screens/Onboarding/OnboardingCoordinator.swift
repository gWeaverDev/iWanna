//
//  OnboardingCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 28.06.2023.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigation = navController
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .onboardingGetStartedTapped:
            let mainCoordinator = MainCoordinator(navigation: navigation)
            childrenCoordinators.append(mainCoordinator)
            mainCoordinator.start()
        default:
            break
        }
    }
    
    func start() {
        let model = OnboardingViewModelImp()
        model.coordinator = self
        let controller = OnboardingVC(viewModel: model)
        navigation.setViewControllers([controller], animated: false)
    }
    
}
