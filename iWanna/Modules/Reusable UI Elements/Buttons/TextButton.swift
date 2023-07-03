//
//  TextButton.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class TextButton: UIButton {
    
    enum Style {
        case back
        case clearAll
        case skip
        case next
        case getStarted
        
        var title: String {
            switch self {
            case .back:
                return L10n.buttonBack()
            case .clearAll:
                return L10n.buttonClearAll()
            case .skip:
                return L10n.buttonSkip()
            case .next:
                return L10n.buttonNext()
            case .getStarted:
                return L10n.buttonGetStarted()
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .back, .clearAll:
                return R.color.grayText()!
            case .skip, .next, .getStarted:
                return R.color.darkText()!
            }
        }
        
        var pressedTitleColor: UIColor {
            switch self {
            case .back:
                return R.color.background_yellow()!
            case .clearAll:
                return R.color.background_gray()!
            case .skip, .next, .getStarted:
                return R.color.background_gray()!
            }
        }
        
        var font: UIFont {
            switch self {
            case .back, .skip, .next, .getStarted:
                return R.font.robotoMedium(size: 18)!
            case .clearAll:
                return R.font.robotoMedium(size: 10)!
            }
        }
        
        func apply(to button: UIButton) {
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .highlighted)
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(pressedTitleColor, for: .highlighted)
            button.titleLabel?.font = font
        }
    }
    
    private var style: Style = .back
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    convenience init(_ style: Style) {
        self.init(frame: .zero)
        self.style = style
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
