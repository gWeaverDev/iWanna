//
//  DetailInfoCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit

final class DetailInfoCell: UITableViewCell {
    
    enum Actions {
        case willWatch(_ isTapped: Bool)
        case share
    }
    
    struct Model {
        let id: Int
        let movieName: String
        let rating: Double
        let yearOfRelease: Int
        let genres: [String]
        let countries: [String]
    }
    
    var buttonAction: ((Actions) -> Void)?
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_light()
        label.font = R.font.oswaldRegular(size: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let moreInfo: UILabel = {
        let label = UILabel()
        label.textColor = R.color.background_gray()
        label.font = R.font.robotoLight(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let willWatchButton = TextAndImageButton(.iWillWatch)
    private let shareButton = TextAndImageButton(.share)
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
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
        super.prepareForReuse()
        movieName.text = ""
        moreInfo.text = ""
    }
    
    func fill(from model: Model) {
        let arrayOfGenres = model.genres
        let joinedGenres = arrayOfGenres.joined(separator: ", ")
        
        let arrayOfCountries = model.countries
        let joinedCountries = arrayOfCountries.joined(separator: ", ")
        
        movieName.text = model.movieName
        moreInfo.attributedText = setAttributedText(
            rating: model.rating.rounded(toPlaces: 1),
            year: model.yearOfRelease,
            genres: joinedGenres,
            countries: joinedCountries
        )
    }
    
    private func addTargets() {
        willWatchButton.addTarget(self, action: #selector(willWatchTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        horizontalStack.addArrangedSubviews(willWatchButton, shareButton)
        contentView.addSubviewsWithoutAutorezing(movieName, moreInfo, horizontalStack)
        
        NSLayoutConstraint.activate([
            
            movieName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieName.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            movieName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            moreInfo.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 2),
            moreInfo.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            moreInfo.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            moreInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            horizontalStack.topAnchor.constraint(equalTo: moreInfo.bottomAnchor, constant: 20),
            horizontalStack.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            willWatchButton.heightAnchor.constraint(equalToConstant: 41),
            willWatchButton.widthAnchor.constraint(equalToConstant: 70),
            
            shareButton.heightAnchor.constraint(equalToConstant: 45),
            shareButton.widthAnchor.constraint(equalToConstant: 57)
        ])
    }
    
    private func setAttributedText(rating: Double, year: Int, genres: String, countries: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let ratingString = NSMutableAttributedString(string: "\(rating) \n")
        ratingString.addAttributes(
            [
                .foregroundColor: R.color.background_yellow() as Any,
                .font: R.font.robotoLight(size: 16) as Any,
                .paragraphStyle: paragraphStyle
            ],
            range: NSRange(location: 0, length: ratingString.length)
        )
        
        let yearAndGenresString = NSMutableAttributedString(string: "\(year), \(genres) \n \(countries)")
        yearAndGenresString.addAttributes(
            [
                .foregroundColor: R.color.grayText() as Any,
                .font: R.font.robotoLight(size: 16) as Any,
                .paragraphStyle: paragraphStyle
            ],
            range: NSRange(location: 0, length: yearAndGenresString.length)
        )
        
        attributedString.append(ratingString)
        attributedString.append(yearAndGenresString)
        
        return attributedString
    }
    
    @objc
    private func willWatchTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? buttonAction?(.willWatch(true)) : buttonAction?(.willWatch(false))
        sender.setTitleColor(sender.isSelected ? R.color.background_yellow() : R.color.grayText(), for: .normal)
        sender.setImage(sender.isSelected ? R.image.willWatch_tepped() : R.image.willWatch(), for: .normal)
    }
    
    @objc
    private func shareTapped(_ sender: UIButton) {
        
        sender.setTitleColor(R.color.background_yellow(), for: .normal)
        sender.setImage(R.image.share_tapped(), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.setTitleColor(R.color.grayText(), for: .normal)
            sender.setImage(R.image.share(), for: .normal)
        }
        
        self.buttonAction?(.share)
    }
    
}
