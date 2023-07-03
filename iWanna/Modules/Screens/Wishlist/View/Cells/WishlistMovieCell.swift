//
//  WishlistMovieCell.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit
import Kingfisher

final class WishlistMovieCell: UITableViewCell {
    
    struct Model {
        let id: Int
        let movieImage: String
        let movieName: String
        let rating: Double
        let genres: [String]
    }
    
    enum Actions {
        case share
        case elementsTapped
    }
    
    var buttonAction: ((Actions) -> Void)?
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_dark()
        label.font = R.font.robotoMedium(size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_yellow()
        label.font = R.font.robotoRegular(size: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.grayText()
        label.font = R.font.robotoLight(size: 10)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let shareButton = TextAndImageButton(.share)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        addTargets()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImage.kf.setImage(with: URL(string: ""))
        movieName.text = ""
        ratingLabel.text = ""
        genresLabel.text = ""
    }
    
    func fill(with model: Model) {
        let arrayOfGenres = model.genres
        let joinedGenres = arrayOfGenres.joined(separator: ", ")
        
        movieImage.kf.setImage(with: URL(string: model.movieImage))
        movieName.text = model.movieName
        ratingLabel.text = "\(model.rating.rounded(toPlaces: 1))"
        genresLabel.text = joinedGenres
    }
    
    private func addTargets() {
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        let elementsUI = [movieImage, movieName, ratingLabel, genresLabel]

        for item in [movieImage, movieName, ratingLabel, genresLabel] {
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(elementsAction))
            item.addGestureRecognizer(tapGR)
        }
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(movieImage, movieName, ratingLabel, genresLabel, shareButton)
        
        NSLayoutConstraint.activate([
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            movieImage.heightAnchor.constraint(equalToConstant: 88),
            movieImage.widthAnchor.constraint(equalToConstant: 88),
            
            movieName.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 15),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieName.trailingAnchor.constraint(lessThanOrEqualTo: shareButton.trailingAnchor, constant: -10),
            
            ratingLabel.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            
            genresLabel.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 4),
            genresLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5),
            genresLabel.trailingAnchor.constraint(lessThanOrEqualTo: shareButton.leadingAnchor),
            
            shareButton.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            shareButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    @objc
    private func shareTapped(_ sender: UIButton) {
        buttonAction?(.share)
    }
    
    @objc
    private func elementsAction(_ sender: UIView) {
        buttonAction?(.elementsTapped)
    }
}
