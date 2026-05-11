//
//  NetworkReachability .swift
//  SportsApp
//
//  Created by Fatema Emara on 11/05/2026.
//

import Foundation
import SystemConfiguration

class NetworkReachability {
    static func isConnected() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        guard let reachability = SCNetworkReachabilityCreateWithName(
            nil, "www.google.com") else { return false }
        SCNetworkReachabilityGetFlags(reachability, &flags)
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
}
