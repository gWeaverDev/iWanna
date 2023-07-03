//
//  ReachabilityManager.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import Foundation
import Alamofire

class ReachabilityManager {

    static let shared = ReachabilityManager()

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    var isReachable = false
    func startNetworkReachabilityObserver() {

    reachabilityManager?.startListening { status in
        switch status {
        case .notReachable:
            self.setEthernetStatusMessage(reachible: false)
        case .unknown :
                return
        case .reachable(.ethernetOrWiFi):
            self.setEthernetStatusMessage(reachible: true)
        case .reachable(.cellular):
            self.setEthernetStatusMessage(reachible: true)
            }
        }
    }

    func setEthernetStatusMessage(reachible: Bool) {
        AlertManager.shared.dismissNotification()
        let alert = SmallNotificationAlert()
        if reachible {
            if isReachable {
                alert.setImage(R.image.notification_ok())
                alert.setTitle(L10n.ethernetStatusDescriptionAvailable())
                alert.setColor(R.color.greenNotification()!)
                alert.setDismissTime(5)
                AlertManager.shared.addAlertView(alert)
                isReachable = false
            }
        } else {
            if !isReachable {
                alert.setImage(R.image.notification_error())
                alert.setTitle(L10n.ethernetStatusDescriptionNotAvailable())
                alert.setColor(R.color.redNotification()!)
                AlertManager.shared.addAlertView(alert)
                isReachable = true
            }
        }
    }
}
