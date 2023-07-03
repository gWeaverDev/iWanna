//
//  FilterButtonCell.swift
//  iWanna
//
//  Created by George Weaver on 02.07.2023.
//

import UIKit

final class FilterButtonCell: UITableViewCell {
    
    struct Model {
        
    }
    
    enum Actions {
        case showTapped
        case backTapped
    }
    
    var buttonActions: ((Actions) -> Void)?
    
    private let showButton = RoundButton(.yellow(title: L10n.buttonShow()))
    private let backButton = TextButton(.back)
    
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
        showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(showButton, backButton)
        
        NSLayoutConstraint.activate([
            showButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            showButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 37),
            showButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -37),
            showButton.heightAnchor.constraint(equalToConstant: 46),
            
            backButton.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 25),
            backButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 37),
            backButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -37),
            backButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 21),
            backButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc
    private func showTapped(_ sender: UIButton) {
        buttonActions?(.showTapped)
    }
    
    @objc
    private func backTapped(_ sender: UIButton) {
        buttonActions?(.backTapped)
    }
}
