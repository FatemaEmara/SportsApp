//
//  NetworkReachability.swift
//  SportsApp
//
//  Created by Fatema Emara on 11/05/2026.
//
//
import Foundation
import Network


final class NetworkReachability {
    static let shared = NetworkReachability()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    private(set) var isConnectedFlag: Bool = false
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let newStatus = (path.status == .satisfied)
            self.isConnectedFlag = newStatus
            DispatchQueue.main.async {
                if newStatus {
                    NotificationCenter.default.post(name: .internetConnected, object: nil)
                } else {
                    NotificationCenter.default.post(name: .internetDisconnected, object: nil)
                }
            }
        }
        monitor.start(queue: queue)
    }

    static func isConnected() -> Bool {
        return shared.isConnectedFlag
    }
}

extension Notification.Name {
    static let internetConnected    = Notification.Name("internetConnected")
    static let internetDisconnected = Notification.Name("internetDisconnected")
}
