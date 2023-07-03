//
//  AnimationHelper.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import UIKit

final class AnimationHelper {

    private var window: UIWindow?

    func presentWithWaterDropAnimation(_ view: Dismissible, position: CGRect) {
        view.dismiss = { [weak self] in self?.handleWindowTap() }
        createWindow()
        makeWaterDropAnimation(position)
        window?.addSubview(view)
    }

    private func createWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = R.color.alertBackground()!
        let recognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleWindowTap))
        window.addGestureRecognizer(recognizer)
        self.window = window
    }

    private func makeWaterDropAnimation(_ position: CGRect) {
        createMaskWith(position)
        window?.isHidden = false

        let layer = CAShapeLayer()

        let startInset: CGFloat = 2
        let endInset: CGFloat = 8
        let startSize = position.width + startInset * 2
        let endSize = position.width + endInset * 2
        let startPath = UIBezierPath(roundedRect: CGRect(x: -startInset, y: -startInset, width: startSize, height: startSize), cornerRadius: startSize / 2)
        let endPath = UIBezierPath(roundedRect: CGRect(x: -endInset, y: -endInset, width: endSize, height: endSize), cornerRadius: endSize / 2)

        let borderLayer = CALayer()
        borderLayer.frame = position.insetBy(dx: -startInset, dy: -startInset)
        borderLayer.backgroundColor = UIColor.white.cgColor
        borderLayer.cornerRadius = borderLayer.bounds.height / 2

        layer.path = startPath.cgPath
        layer.frame = position
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor

        CATransaction.begin()

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = 0.3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        pathAnimation.fromValue = startPath.cgPath
        pathAnimation.toValue =  endPath.cgPath

        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.duration = 0.3
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0

        CATransaction.setCompletionBlock { [weak layer] in layer?.removeFromSuperlayer() }

        let group = CAAnimationGroup()
        group.duration = 0.3
        group.animations = [fadeAnimation, pathAnimation]

        layer.add(group, forKey: nil)
        window?.layer.addSublayer(layer)
        window?.layer.addSublayer(borderLayer)

        CATransaction.commit()
    }

    private func createMaskWith(_ position: CGRect) {
        guard let window = window else { return }
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: position, cornerRadius: position.height / 2)
        path.append(UIBezierPath(rect: window.bounds))
        layer.path = path.cgPath
        layer.frame = window.bounds
        layer.fillRule = .evenOdd
        layer.cornerRadius = position.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        window.layer.mask = layer
    }

    @objc
    private func handleWindowTap() {
        window = nil
//        window.isHidden = true
//        window.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
//        window.subviews.forEach({ $0.removeFromSuperview() })
//        completion?()
    }
}
