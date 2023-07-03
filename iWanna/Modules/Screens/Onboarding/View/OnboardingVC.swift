//
//  FirstScreenVC.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

final class OnboardingVC: UIViewController {
    
    private let viewModel: OnboardingViewModel
    private let pagination = PaginationView()
    private var nextButton = TextButton(.next)
    private let skipButton = TextButton(.skip)
    private lazy var onboardingCollectionView = OnboardingCollectionView(viewModel: viewModel)
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAppearance()
        setupLayout()
        setupTargets()
    }
    
    private func setupUI() {
        pagination.numberOfPages = viewModel.onboardings.count
        pagination.currentPage = 0
    }
    
    private func setupAppearance() {
        view.backgroundColor = R.color.background_light()
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutorezing(onboardingCollectionView, skipButton, pagination, nextButton)
        
        NSLayoutConstraint.activate([
            
            onboardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: pagination.topAnchor, constant: -48),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            skipButton.trailingAnchor.constraint(lessThanOrEqualTo: pagination.leadingAnchor, constant: -10),
            skipButton.heightAnchor.constraint(equalToConstant: 21),
            
            pagination.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            pagination.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pagination.widthAnchor.constraint(equalToConstant: 30),
            pagination.heightAnchor.constraint(equalToConstant: 12),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            nextButton.leadingAnchor.constraint(greaterThanOrEqualTo: pagination.trailingAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    private func setupTargets() {
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc
    private func skipTapped(_ sender: UIButton) {
        viewModel.skipOrStartedButtonTapped()
    }
    
    @objc
    private func nextTapped(_ sender: UIButton) { //TODO: - need fixed
        let visibleItems = self.onboardingCollectionView.indexPathsForVisibleItems
        guard let currentItem = visibleItems.first else { return }
        let isLastSlide = currentItem.item == viewModel.onboardings.count - 1

        if isLastSlide {
            viewModel.skipOrStartedButtonTapped()
        } else {
            let nextItem = IndexPath(item: currentItem.item + 1, section: 0)
            self.onboardingCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
            viewModel.nextButtonTapped()
        }
    }
}

extension OnboardingVC: OnboardingViewModelDelegate {

    func changeBeginButtonCondition(condition: Bool) {
        nextButton.setTitle(condition ? L10n.buttonGetStarted() : L10n.buttonNext(), for: .normal)
        skipButton.isHidden = condition
    }

    func changeCurrentPage(newPage: Int) {
        pagination.currentPage = newPage
    }
}
