//
//  MultiMoyaProvider.swift
//  iWanna
//
//  Created by George Weaver on 26.06.2023.
//

import Foundation
import Moya

final class MultiMoyaProvider: MoyaProvider<MultiTarget> {
    
    typealias Target = MultiTarget
    
    override init(
        endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<MultiTarget>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider<Target>.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session,
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
}

extension MultiMoyaProvider {
    
    func multiRequest(_ target: Target, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        if !ReachabilityManager.shared.isReachable {
            self.request(target) { result in
                switch result {
                case .failure:
                    completion(result)
                case .success(let response):
                    switch response.statusCode {
                    case 401:
                        if target.path.contains("sessions") {
                            completion(result)
                        }
                    default:
                        completion(result)
                    }
                }
            }
        } else {
            showNoEthernetAlert()
            // hide activityIndicator or make ProgressHud
        }
    }
    
    func showNoEthernetAlert() {
        AlertManager.shared.dismissNotification()
        let alert = SmallNotificationAlert()
        alert.setImage(R.image.notification_error())
        alert.setTitle(L10n.ethernetStatusDescriptionNotAvailable())
        alert.setColor(R.color.redNotification()!)
        AlertManager.shared.addAlertView(alert)
    }
}
