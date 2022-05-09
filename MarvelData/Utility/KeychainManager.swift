//
//  KeychainManager.swift
//  MarvelData
//
//  Created by Swapnali Patil on 01/05/22.
//

import Foundation
import SwiftKeychainWrapper

enum KeyConstant {
    static let strAPIKey = "APIKey"
    static let strPrivateKey = "PrivateKey"
    static let APIKeyValue = "31a12201f01fca232b3bc380d3d2de7d"
    static let PrivateKeyValue = "fb92bfe19243285af803d8d690ee7514c3de0685"
}

class KeychainManager {
    static func setPublicKey() {
        KeychainWrapper.standard.set(KeyConstant.APIKeyValue, forKey: KeyConstant.strAPIKey)
    }
    
    static func setPrivateKey() {
        KeychainWrapper.standard.set(KeyConstant.PrivateKeyValue, forKey: KeyConstant.strPrivateKey)
    }
    
    static func getPublicKey() -> String {
        KeychainWrapper.standard.string(forKey: KeyConstant.strAPIKey) ?? ""
    }
    
    static func getPrivateKey() -> String {
        KeychainWrapper.standard.string(forKey: KeyConstant.strPrivateKey) ?? ""
    }
    
    static func getHashValue(timestamp: String) -> String {
        let publicKey = KeychainManager.getPublicKey()
        let privateKey = KeychainManager.getPrivateKey()
        
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5() ?? ""
        return hash
    }
}
