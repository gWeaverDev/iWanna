//
//  OnboardingCollectionViewCell.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    struct Model {
        let image: UIImage
        let text: String
        let subtitle: String
    }

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let text: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = R.font.robotoMedium(size: 26)
        label.textColor = R.color.darkText()
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = R.font.robotoRegular(size: 18)
        label.textColor = R.color.darkText()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviewsWithoutAutorezing(image, text, subtitle)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 363),
            image.heightAnchor.constraint(equalToConstant: 343),
            
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            text.centerXAnchor.constraint(equalTo: centerXAnchor),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            
            subtitle.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 18),
            subtitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60)
        ])
    }

    func fill(from model: Model) {
        image.image = model.image
        text.attributedText = setupText(model.text)
        subtitle.attributedText = setupText(model.subtitle)
    }

    private func setupText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .center
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(0..<attributedString.length)
        )
        return attributedString
    }

}
