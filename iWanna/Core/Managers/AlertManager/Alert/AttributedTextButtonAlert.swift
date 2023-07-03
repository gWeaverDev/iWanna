//
//  AttributedTextButtonAlert.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import UIKit

final class AttributedTextButtonAlert: BaseAlert {

    private let exitButton: RoundButton = RoundButton(.pink(title: ""))
    
    private var buttonCallBack: (() -> Void)?
    
    private let messageBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = R.color.aliceBlue()!
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = R.font.robotoRegular(size: 17)
        label.textColor = R.color.deselectedText()!
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public convenience init() {
        self.init(frame: UIScreen.main.bounds)
        setupLayout()
        exitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    public func setTitleOrAndDescription(title: String = "", description: String = "") {
        let title = NSMutableAttributedString(
            string: title,
            attributes: [
                .font: R.font.robotoMedium(size: 24) as Any
            ]
        )
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3.5
        
        let description = NSMutableAttributedString(
            string: description,
            attributes: [
                .font: R.font.robotoMedium(size: 17) as Any,
                .paragraphStyle: style
            ]
        )
        
        title.append(description)
        messageLabel.attributedText = title
        messageLabel.textAlignment = .center
    }

    public func setAttributedString(text: NSAttributedString) {
        messageLabel.attributedText = text
        messageLabel.textAlignment = .center
    }

    public func setButtonTitle(text: String) {
        exitButton.setTitle(text, for: .normal)
    }

    public func setButtonCallBack(callback: (() -> Void)?) {
        buttonCallBack = callback
    }

    public func setupCloseByTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func buttonAction(sender: UIButton) {
        AlertManager.shared.dismissAlert()
        self.buttonCallBack?()
    }

    @objc private func handleTap(touch: UITouch) {
        AlertManager.shared.dismissAlert()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviewsWithoutAutorezing(messageBackground)
        messageBackground.addSubviewsWithoutAutorezing(messageLabel, exitButton)

        NSLayoutConstraint.activate([
            messageBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            messageBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),

            messageLabel.topAnchor.constraint(equalTo: messageBackground.topAnchor, constant: 39),
            messageLabel.centerXAnchor.constraint(equalTo: messageBackground.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 29),

            exitButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 27),
            exitButton.bottomAnchor.constraint(equalTo: messageBackground.bottomAnchor, constant: -36),
            exitButton.centerXAnchor.constraint(equalTo: messageBackground.centerXAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 21),
            exitButton.widthAnchor.constraint(equalToConstant: 47)
        ])
    }
}

extension AttributedTextButtonAlert: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      let location = touch.location(in: nil)
      if messageBackground.frame.contains(location) { return false }
      return true
    }
}
