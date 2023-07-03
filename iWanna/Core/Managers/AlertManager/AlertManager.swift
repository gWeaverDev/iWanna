//
//  AlertManager.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import Foundation
import UIKit

public class AlertManager {
    
    public static let shared = AlertManager()
    
    private static let alertObserverId = "Alert Manager"
    
    public var alertObserver = Observer<Bool>(value: false)
    public private(set) var pendingAlertViews: [UIView] = []
    private var animationHelper = AnimationHelper()
    
    private init() {}

    public func addAlertView(_ alertView: UIView) {
        
        if pendingAlertViews.contains(alertView) {
            return
        }
        
        pendingAlertViews.append(alertView)
        alertObserver.post(value: true)
    }

    func showAlertWithDropAnimation(_ alert: Dismissible, position: CGRect) {
        animationHelper.presentWithWaterDropAnimation(alert, position: position)
    }

    private func showAlert(animated: Bool = true) {
        DispatchQueue.main.async {
            guard let screen = UIApplication.shared.currentWindow else {
                self.alertObserver.post(value: true)
                return
            }
            
            if self.alertIsAlreadyShowing { self.alertObserver.post(value: true); return }
            guard self.pendingCount > 0 else { return }
            guard let alert = self.topAlert else { return }

            if alert is BaseAlert {
                screen.endEditing(true)
                self.constraintBase(in: screen, for: alert)
            }

            if alert is SmallNotificationAlert {
                self.constraintNotification(in: screen, for: alert)
            }

            self.pendingAlertViews.remove(at: 0)
        }
    }
    
    private func constraintBase(in view: UIView, for subview: UIView) {
        view.addSubviews(subview)
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.topAnchor),
            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func constraintNotification(in view: UIView, for subview: UIView) {
        view.addSubviews(subview)
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38)
        ])
    }

    public func dismissAlert() {
        guard let screen = UIApplication.shared.currentWindow else { return }
        for view in screen.subviews where view is BaseAlert {
            view.removeFromSuperview()
            self.alertObserver.post(value: true)
        }
    }

    public func dismissNotification() {
        guard let screen = UIApplication.shared.currentWindow else { return }
        for view in screen.subviews where view is SmallNotificationAlert {
            view.removeFromSuperview()
            self.alertObserver.post(value: true)
        }
    }

    internal func setupAlertChangeObserver() {
        alertObserver.bind(id: Self.alertObserverId) { _, queueHasChanged in
            if queueHasChanged {
                self.showAlert()
            }
        }
    }

    private var alertIsAlreadyShowing: Bool {
        guard let screen = UIApplication.shared.currentWindow else { return false }
        for view in screen.subviews {
            if view is BaseAlert || view is SmallNotificationAlert {
                return true
            }
        }
        return false
    }

    public var pendingCount: Int {
        self.pendingAlertViews.count
    }

    public var hasPendingAlerts: Bool {
        pendingCount == 0
    }

    private var topAlert: UIView? {
        guard let topAlert = pendingAlertViews.first else { return nil }
        return topAlert
    }
}

