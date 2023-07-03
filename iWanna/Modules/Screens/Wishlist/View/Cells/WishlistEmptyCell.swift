//
//  WishlistEmptyCell.swift
//  iWanna
//
//  Created by George Weaver on 03.07.2023.
//

import UIKit

final class WishlistEmptyCell: UITableViewCell {
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.wishlistTitleEmpty()
        label.textColor = R.color.background_dark()
        label.font = R.font.robotoRegular(size: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            emptyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            emptyLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            emptyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
