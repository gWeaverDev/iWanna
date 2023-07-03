//
//  ImageButton.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class ImageButton: UIButton {
    
    enum Style {
        case filter
        case wishList
        
        var normalImage: UIImage {
            switch self {
            case .filter:
                return R.image.filter()!
            case .wishList:
                return R.image.wishlist()!
            }
        }
        
        var tappedImage: UIImage {
            switch self {
            case .filter:
                return R.image.filter_tapped()!
            case .wishList:
                return R.image.wishlist_tapped()!
            }
        }
        
        func apply(to button: UIButton) {
            button.setImage(normalImage, for: .normal)
            button.setImage(tappedImage, for: .highlighted)
        }
    }
    
    private var style: Style = .filter
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    convenience init(_ style: Style) {
        self.init(frame: .zero)
        configure(style)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ style: Style) {
        self.style = style
        style.apply(to: self)
        self.isExclusiveTouch = true
    }
}
