//
//  DetailPosterCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit
import Kingfisher

final class DetailPosterCell: UITableViewCell {
    
    struct Model {
        let posterImage: String
    }
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
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
        posterImage.kf.setImage(with: URL(string: ""))
    }
    
    func fill(from model: Model) {
        posterImage.kf.setImage(with: URL(string: model.posterImage))
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}
