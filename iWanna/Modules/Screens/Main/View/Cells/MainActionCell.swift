//
//  MainActionCell.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit

final class MainActionCell: UITableViewCell {
    
    struct Model {
        
    }
    
    enum Actions {
        case filterTapped
        case wishlistTapped
    }
    
    var buttonAction: ((Actions) -> Void)?
    
    private let leftActionButton = ImageButton(.filter)
    private let rightActionButton = ImageButton(.wishList)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        cellAppearance()
        addTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(from model: Model) {}
    
    private func addTargets() {
        leftActionButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        rightActionButton.addTarget(self, action: #selector(wishlistTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(leftActionButton, rightActionButton)
        
        NSLayoutConstraint.activate([
            leftActionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14.5),
            leftActionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 31),
            leftActionButton.widthAnchor.constraint(equalToConstant: 27),
            leftActionButton.heightAnchor.constraint(equalToConstant: 27),
            leftActionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14.5),
            
            rightActionButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightActionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightActionButton.widthAnchor.constraint(equalToConstant: 64),
            rightActionButton.heightAnchor.constraint(equalToConstant: 56),
            rightActionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    @objc
    private func filterTapped(_ sender: UIButton) {
        buttonAction?(.filterTapped)
    }
    
    @objc
    private func wishlistTapped(_ sender: UIButton) {
        buttonAction?(.wishlistTapped)
    }
}
