//
//  MainCollectionTableViewCell.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

final class MainCollectionCell: UITableViewCell {
    
    struct Model {
        let dataItems: [MovieCellViewModel]
    }
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private var model: Model?
    var cellTapped: (() -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.registerCells(withModels: MovieCellViewModel.self)
        collection.decelerationRate = .fast
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.model = nil
        self.cellTapped = nil
    }
    
    func fill(from model: Model) {
        self.model = model
        collectionView.reloadData()
    }
    
    private func setupUI() { 
        collectionView.delegate = self
        collectionView.dataSource = self
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 250, height: 500)
        flowLayout.minimumLineSpacing = 10
        
        let insetX = (contentView.bounds.width - 270) / 2
        let insetY = (contentView.bounds.height - 500) / 2
        
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(cellAction))
        contentView.addGestureRecognizer(tapGR)
        
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc
    private func cellAction() {
        cellTapped?()
        print("!!!! mainCollectionCell tapped")
    }
}

extension MainCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.dataItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = model?.dataItems[indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)
        model.configureAny(cell)
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / 25
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * 25 - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }

}
