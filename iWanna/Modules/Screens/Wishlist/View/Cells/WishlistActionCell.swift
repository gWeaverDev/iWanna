//
//  WishlistActionCell.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

final class WishlistActionCell: UITableViewCell {
    
    struct Model {
        
    }
    
    enum Actions {
        case clearAll
    }
    
    var buttonAction: ((Actions) -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.wishlistMainTitle()
        label.font = R.font.oswaldRegular(size: 26)
        label.textColor = R.color.background_dark()
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let clearButton = TextButton(.clearAll)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        addTargets()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(from model: Model) {}
    
    private func addTargets() {
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(titleLabel, clearButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            clearButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc
    private func clearTapped(_ sender: UIButton) {
        buttonAction?(.clearAll)
    }
}
