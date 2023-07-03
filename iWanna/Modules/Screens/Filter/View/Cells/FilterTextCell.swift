//
//  FilterTextCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class FilterTextCell: UITableViewCell {
    
    struct Model {
        let titleText: String
    }
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_light()
        label.font = R.font.oswaldRegular(size: 26)
        label.textAlignment = .center
        label.numberOfLines = 1
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
        mainTitle.text = ""
    }
    
    func fill(from model: Model) {
        mainTitle.text = model.titleText
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(mainTitle)
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42),
            mainTitle.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            mainTitle.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            mainTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
