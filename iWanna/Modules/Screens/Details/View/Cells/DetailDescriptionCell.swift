//
//  DetailDescriptionCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class DetailDescriptionCell: UITableViewCell {
    
    struct Model {
        let descriptionText: String
    }
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.background_gray()
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_light()
        label.font = R.font.robotoRegular(size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = ""
    }
    
    func fill(from model: Model) {
        descriptionLabel.text = model.descriptionText
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(separatorLine, descriptionLabel)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
