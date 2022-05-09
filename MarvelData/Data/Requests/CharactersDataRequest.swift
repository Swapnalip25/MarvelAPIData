//
//  CharactersDataRequest.swift
//  MarvelData
//
//  Created by Swapnali Patil on 20/04/22.
//

import Foundation

class CharactersDataRequest: ApiRequest {
    let limit: Int
    let offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        var parameters = [String:Any]()
        parameters[ParameterConstant.limit] = self.limit
        parameters[ParameterConstant.offset] = self.offset
        parameters[ParameterConstant.APIKey] = KeychainManager.getPublicKey()
        
        let ts = NSDate().timeIntervalSince1970.description
        parameters[ParameterConstant.timestamp] = ts
        parameters[ParameterConstant.hash] = KeychainManager.getHashValue(timestamp: ts)
        super.init(endpoint: .getCharactersData, parameters: parameters)
    }
    
}


