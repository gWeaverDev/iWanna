//
//  OnboardingViewModel.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import Foundation

protocol OnboardingViewModel: AnyObject {
    var delegate: OnboardingViewModelDelegate? { get set }
    var routing: (OnboardingViewModelFlow) -> Void { get set }
    var selectedPage: Int { get }
    var onboardings: [OnboardingCollectionViewCell.Model] { get }
    func currentPageDidChangeTo(newNumber: Int)
    func nextButtonTapped()
    func skipOrStartedButtonTapped()
}

protocol OnboardingViewModelDelegate: AnyObject {
    func changeBeginButtonCondition(condition: Bool)
    func changeCurrentPage(newPage: Int)
}

enum OnboardingViewModelFlow {
    case toMain
}

final class OnboardingViewModelImp: OnboardingViewModel, Coordinating {
    
    var coordinator: Coordinator?
    
    weak var delegate: OnboardingViewModelDelegate?
    
    var routing: (OnboardingViewModelFlow) -> Void = { _ in }
    
    var selectedPage: Int {
        return currentPage
    }
    
    var onboardings: [OnboardingCollectionViewCell.Model] = [
        OnboardingCollectionViewCell.Model(
            image: R.image.welcome_1()!,
            text: L10n.onboardingFirstPageTitle(),
            subtitle: L10n.onboardingFirstPageSubtitle()
        ),
        OnboardingCollectionViewCell.Model(
            image: R.image.welcome_2()!,
            text: L10n.onboardingSecondPageTitle(),
            subtitle: L10n.onboardingSecondPageSubtitle()
        )
    ]
    
    private let userDefaults = UserDefaultsManager()
    private var currentPage: Int = 0
    
    init() {}
    
    func currentPageDidChangeTo(newNumber: Int) {
        delegate?.changeCurrentPage(newPage: newNumber)
        if newNumber == 1 {
            currentPage = newNumber
            delegate?.changeBeginButtonCondition(condition: true)
        } else {
            currentPage = newNumber
            delegate?.changeBeginButtonCondition(condition: false)
        }
    }

    func nextButtonTapped() {
        currentPage += 1
        
        if currentPage >= onboardings.count - 1 {
            // Последняя страница, изменяем тайтл кнопки на "Get Started"
            delegate?.changeBeginButtonCondition(condition: true)
        }
        
        delegate?.changeCurrentPage(newPage: currentPage)
    }
    
    func skipOrStartedButtonTapped() {
        userDefaults.isOnboardingCompleted = true
        coordinator?.eventOccurred(with: .onboardingGetStartedTapped)
    }
    
    
}
