//
//  OnboardingCollectionView.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import UIKit

protocol OnboardingCollectionViewDelegate: AnyObject {
    func currentPageNumberDidChange(newNumber: Int)
}

final class OnboardingCollectionView: UICollectionView {
    
    private let viewModel: OnboardingViewModel
    private let flowLayout = UICollectionViewFlowLayout()
    private var indexOfCellBeforeDragging = 0
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        configureFlowLayout()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFlowLayout() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
    }
    
    private func setupUI() {
        backgroundColor = .clear
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(cellType: OnboardingCollectionViewCell.self)
    }
}

extension OnboardingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.onboardings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardingCollectionViewCell else {
            assertionFailure("Something went wrong")
            return UICollectionViewCell()
        }
        
        let model = viewModel.onboardings[indexPath.row]
        cell.fill(from: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: self.bounds.height)
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let page: Int = Int(targetContentOffset.pointee.x / (self.frame.width))
        viewModel.currentPageDidChangeTo(newNumber: page)
    }
}
