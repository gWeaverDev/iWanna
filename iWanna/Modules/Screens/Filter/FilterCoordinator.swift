//
//  FilterCoordinator.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterCoordinator: Coordinator {
    
    var childrenCoordinators: [Coordinator] = []
    
    var navigation: UINavigationController
    
    private var filtersModel: FiltersModel?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .filterShowTapped(let filtersModel):
            let mainCoordinator = MainCoordinator(navigation: navigation)
            childrenCoordinators.append(mainCoordinator)
            mainCoordinator.filtersModel = filtersModel
            mainCoordinator.start()
            navigation.dismiss(animated: true)
        case .filterBackTapped:
            navigation.dismiss(animated: true)
        default:
            break
        }
    }
    
    func start() {
        let model = FilterViewModelImpl()
        model.coordinator = self
        let controller = FilterVC(viewModel: model)
        controller.modalPresentationStyle = .fullScreen
        navigation.present(controller, animated: true)
    }
    
    func setFiltersModel(_ filtersModel: FiltersModel) {
        self.filtersModel = filtersModel
    }
    
}
