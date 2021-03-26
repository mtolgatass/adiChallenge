//
//  AdiReachibility.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 26.03.2021.
//

import Foundation
import SystemConfiguration

class Reachability {
    
    static var sharedInstance: Reachability = Reachability()
        
    func isNetworkConnectionAvailable() -> Bool {
        
        guard let reachability = getReachability() else { return false }
        
        var flags: SCNetworkReachabilityFlags = []
        
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func getReachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return nil
        }
        return reachability
    }
}
