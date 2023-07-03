//
//  FilterGenreCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterGenreCell: UITableViewCell {
    
    struct Model {
        
    }
    
    var buttonTapped: ((String) -> Void)?
    
    private var activeButton: UIButton?
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.filtersTitleGenre()
        label.font = R.font.robotoMedium(size: 18)
        label.textColor = R.color.background_light()
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        setupStackView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(from model: Model) {}
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(genreLabel, buttonsStack)
        
        NSLayoutConstraint.activate([
            
            genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            genreLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -30),
            
            buttonsStack.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15),
            buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupStackView() {
        
        let arrayOfGenres = [
            L10n.filtersGenreAction(), L10n.filtersGenreFantastic(), L10n.filtersGenreDrama()
        ]

        for (index, genre) in arrayOfGenres.enumerated() {
            let itemButton = RoundButton(.transparentWithBorder(title: "\(genre)"))
            itemButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            itemButton.titleLabel?.adjustsFontSizeToFitWidth = true
            itemButton.titleLabel?.minimumScaleFactor = 0.5
            itemButton.titleLabel?.numberOfLines = 1
            itemButton.tag = index + 1
            itemButton.sizeToFit()
            buttonsStack.addArrangedSubview(itemButton)
            
            NSLayoutConstraint.activate([
                itemButton.heightAnchor.constraint(equalToConstant: 32),
                itemButton.widthAnchor.constraint(equalToConstant: 110)
            ])
        }
    }
    
    @objc
    private func buttonAction(_ sender: UIButton) {
        let genre = sender.isSelected ? "" : sender.titleLabel?.text ?? ""
                
        activeButton?.isSelected = false
        activeButton?.setTitleColor(R.color.background_gray(), for: .normal)
        activeButton?.layer.borderColor = R.color.background_gray()?.cgColor
        
        if sender == activeButton {
            activeButton = nil
        } else {
            sender.isSelected = true
            sender.setTitleColor(R.color.background_yellow(), for: .normal)
            sender.layer.borderColor = R.color.background_yellow()?.cgColor
            activeButton = sender
        }

        buttonTapped?(genre.mapGenre())
    }
}
