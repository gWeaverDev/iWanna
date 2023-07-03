//
//  MainTextCell.swift
//  iWanna
//
//  Created by George Weaver on 29.06.2023.
//

import UIKit

final class MainTextCell: UITableViewCell {
    
    struct Model {
        let title: String
    }
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_light()
        label.font = R.font.oswaldBold(size: 26)
        label.numberOfLines = 1
        label.textAlignment = .center
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
        mainTitle.text = model.title
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(mainTitle)
        
        NSLayoutConstraint.activate([
            
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTitle.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            mainTitle.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            mainTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}




