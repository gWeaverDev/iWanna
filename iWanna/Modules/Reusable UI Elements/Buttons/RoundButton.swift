//
//  RoundButton.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class RoundButton: UIButton {
    
    enum Style {
        case white(title: String?)
        case yellow(title: String?)
        case pink(title: String?)
        case transparentWithBorder(title: String?)
        
        var background: UIColor {
            switch self {
            case .white:
                return .white
            case .yellow:
                return R.color.background_yellow()!
            case .pink:
                return R.color.selectedPink()!
            case .transparentWithBorder:
                return .clear
            }
        }
        
        var pressedBackground: UIColor {
            switch self {
            case .white:
                return .white.withAlphaComponent(0.8)
            case .yellow, .transparentWithBorder:
                return .clear
            case .pink:
                return R.color.palePink()!
            }
        }
        
        var normalTitle: UIColor {
            switch self {
            case .white, .yellow:
                return R.color.background_dark()!
            case .pink:
                return .white
            case .transparentWithBorder:
                return R.color.background_gray()!
            }
        }
        
        var pressedTitle: UIColor {
            switch self {
            case .white, .yellow, .pink:
                return R.color.background_gray()!
            case .transparentWithBorder:
                return R.color.background_yellow()!
            }
        }
        
        var borderColor: CGColor {
            switch self {
            case .white, .yellow, .pink:
                return UIColor.clear.cgColor
            case .transparentWithBorder:
                return R.color.background_gray()!.cgColor
            }
        }
        
        var pressedBorderColor: CGColor {
            switch self {
            case .white, .yellow, .pink:
                return UIColor.clear.cgColor
            case .transparentWithBorder:
                return R.color.background_yellow()!.cgColor
            }
        }
        
        func apply(to button: UIButton) {
            button.setBackgroundColor(background, forState: .normal)
            button.setBackgroundColor(pressedBackground, forState: .highlighted)
            button.setTitleColor(normalTitle, for: .normal)
            button.layer.borderColor = borderColor
            
            switch self {
            case .white(let title), .yellow(let title), .pink(let title):
                button.setTitle(title, for: .normal)
                button.setTitle(title, for: .highlighted)
                button.setTitleColor(pressedTitle, for: .highlighted)
                button.titleLabel?.font = R.font.robotoRegular(size: 18)
            case .transparentWithBorder(let title):
                button.setTitle(title, for: .normal)
                button.setTitle(title, for: .selected)
                button.titleLabel?.font = R.font.robotoRegular(size: 16)
                button.setTitleColor(pressedTitle, for: .selected)
                button.setBackgroundColor(pressedBackground, forState: .selected)
            }
            
        }
    }
    
    private var style: Style = .yellow(title: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(highlightBorder), for: .touchUpInside)
        addTarget(self, action: #selector(unhighlightBorder), for: .touchDown)
        layer.borderWidth = 1
        clipsToBounds = true
    }
    
    convenience init(_ style: Style) {
        self.init(frame: .zero)
        configure(style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.height, bounds.width) / 2
    }
    
    private func configure(_ style: Style) {
        self.style = style
        style.apply(to: self)
        self.isExclusiveTouch = true
    }
    
    @objc
    private func highlightBorder() {
        layer.borderColor = style.borderColor
    }

    @objc
    private func unhighlightBorder() {
        layer.borderColor = style.pressedBorderColor
    }
}
