//
//  MainCollectionMovieCell.swift
//  iWanna
//
//  Created by George Weaver on 25.06.2023.
//

import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    
    struct Model {
        let id: Int
        let posterImage: String
        let movieName: String
    }
    
    var cellTapped: (() -> Void)?
    
    private let posterImage: UIImageView = {
        let poster = UIImageView()
        poster.layer.cornerRadius = 20
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        return poster
    }()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_light()
        label.font = R.font.robotoMedium(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellAppearance()
        addTargets()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.kf.setImage(with: URL(string: ""))
        movieLabel.text = ""
    }
    
    func fill(from model: Model) {
        posterImage.kf.setImage(with: URL(string: model.posterImage))
        movieLabel.text = model.movieName
    }
    
    private func addTargets() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(cellAction))
        contentView.addGestureRecognizer(tapGR)
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(posterImage, movieLabel)
        
        NSLayoutConstraint.activate([
            
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            posterImage.heightAnchor.constraint(equalToConstant: 376),
            posterImage.widthAnchor.constraint(equalToConstant: 267),
            
            movieLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            movieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieLabel.widthAnchor.constraint(equalToConstant: 240),
            movieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc
    private func cellAction() {
        cellTapped?()
        print("!!!! movieCell in collection tapped")
    }
}
