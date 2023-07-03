//
//  AppCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    private let userDefaults: UserDefaultsManager
    
    func eventOccurred(with type: Event) {
        //
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        self.userDefaults = UserDefaultsManager()
    }
    
    func start() {
        setupObservers()
        if userDefaults.isOnboardingCompleted {
            startMain(navigation: navigation)
        } else {
            startOnboarding(navigation: navigation)
        }
    }
    
    private func setupObservers() {
        AlertManager.shared.setupAlertChangeObserver()
        ReachabilityManager.shared.startNetworkReachabilityObserver()
    }
    
    private func startOnboarding(navigation: UINavigationController) {
        let onboardingCoordinator = OnboardingCoordinator(navController: navigation)
        childrenCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func startMain(navigation: UINavigationController) {
        let mainCoordinator = MainCoordinator(navigation: navigation)
        childrenCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
}
