//
//  SmallNoticationAlert.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class SmallNotificationAlert: UIView {

    private var dismisstimer = 0
    private var timer: Timer?
    private let okButton: RoundButton = RoundButton(.white(title: L10n.commonOk()))
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let notificationimgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setImage(_ img: UIImage?) {
        notificationimgView.image = img
    }
    
    func setColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func setDismissTime(_ time: Int) {
        dismisstimer = time
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init() {
        self.init(frame: CGRect(x: 65, y: 40, width: 300, height: 100))
        okButton.titleLabel?.font = R.font.robotoMedium(size: 15)
        self.okButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        setupLayout()
    }
    
    @objc func updateTimer() {
        if dismisstimer == 0 {
            dismissMe()
        }
        dismisstimer -= 1
    }
    
    private func dismissMe() {
        timer?.invalidate()
        timer = nil
        AlertManager.shared.dismissNotification()
    }
    
    @objc func buttonAction(sender: UIButton) {
        dismissMe()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviewsWithoutAutorezing(notificationimgView, titleLabel, okButton)
        
        NSLayoutConstraint.activate([
            
            notificationimgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            notificationimgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            notificationimgView.heightAnchor.constraint(equalToConstant: 31),
            notificationimgView.widthAnchor.constraint(equalToConstant: 31),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: notificationimgView.trailingAnchor, constant: 11),
            titleLabel.trailingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: -11),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            okButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            okButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 29),
            okButton.widthAnchor.constraint(equalToConstant: 72)
            
        ])
    }
}
