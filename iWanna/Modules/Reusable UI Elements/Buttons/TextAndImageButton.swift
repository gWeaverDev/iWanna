//
//  TextAndImageButton.swift
//  iWanna
//
//  Created by George Weaver on 30.06.2023.
//

import UIKit

final class TextAndImageButton: UIButton {
    
    enum Style {
        case iWillWatch
        case share
        case viewed
        
        var buttonTitle: String {
            switch self {
            case .iWillWatch:
                return L10n.detailButtonTitleWillWatch()
            case .share:
                return L10n.detailButtonTitleShare()
            case .viewed:
                return L10n.detailButtonTitleViewed()
            }
        }
        
        var buttonImage: String {
            switch self {
            case .iWillWatch:
                return "willWatch"
            case .share:
                return "share"
            case .viewed:
                return "viewed_off"
            }
        }
        
        var pressedButtonImage: String {
            switch self {
            case .iWillWatch:
                return "willWatch_tapped"
            case .share:
                return "share_tapped"
            case .viewed:
                return "viewed_on"
            }
        }
        
        func apply(to button: UIButton) {
            button.setImage(UIImage(named: buttonImage), for: .normal)
            button.setImage(UIImage(named: pressedButtonImage), for: .highlighted)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitle(buttonTitle, for: .highlighted)
            button.titleLabel?.font = R.font.robotoRegular(size: 10)
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.numberOfLines = 1
            button.setTitleColor(R.color.grayText(), for: .normal)
            button.setTitleColor(R.color.background_yellow(), for: .highlighted)
            
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .center
            
            button.imageEdgeInsets = UIEdgeInsets(
                top: -button.titleLabel!.intrinsicContentSize.height,
                left: 0,
                bottom: 0,
                right: -button.titleLabel!.intrinsicContentSize.width
            )
            
            button.titleEdgeInsets = UIEdgeInsets(
                top: 10,
                left: -button.imageView!.frame.size.width,
                bottom: -button.imageView!.frame.size.height,
                right: 0
            )
            
            
            button.sizeToFit()
        }
    }
    
    var style: Style = .iWillWatch
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
