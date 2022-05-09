//
//  NetworkRechabilityManager.swift
//  MarvelData
//
//  Created by Swapnali Patil on 01/05/22.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    var isRechable: Bool = false
    
    override init() {
        super.init()
        // Initialise reachability
        do {
            self.reachability = try Reachability()
        } catch {
            debugPrint("Unable to create rechability class")
        }
        NotificationCenter.default.addObserver( self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try self.reachability.startNotifier()
        } catch {
            debugPrint("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
        let networkReachability = notification.object as! Reachability;
        let remoteHostStatus = networkReachability.connection
        
        if (remoteHostStatus == .unavailable) {
            NetworkManager.sharedInstance.isRechable = false
        } else if (remoteHostStatus == .wifi || remoteHostStatus == .cellular) {
            NetworkManager.sharedInstance.isRechable = true
        }
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            debugPrint("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            NetworkManager.sharedInstance.isRechable = true
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            NetworkManager.sharedInstance.isRechable = false
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            NetworkManager.sharedInstance.isRechable = true
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            NetworkManager.sharedInstance.isRechable = true
            completed(NetworkManager.sharedInstance)
        }
    }
}
