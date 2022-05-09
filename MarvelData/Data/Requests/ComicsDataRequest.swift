//
//  ComicsDataRequest.swift
//  MarvelData
//
//  Created by Swapnali Patil on 21/04/22.
//

import Foundation

class ComicsDataRequest: ApiRequest {
    let limit: Int
    let offset: Int
    let dateDescriptor: String
    
    init(limit: Int, offset: Int, type: SortType) {
        self.limit = limit
        self.offset = offset
        self.dateDescriptor = ParameterConstant.getDateDescriptorString(type: type)
        var parameters = [String:Any]()
        parameters[ParameterConstant.limit] = self.limit
        parameters[ParameterConstant.offset] = self.offset
        if !self.dateDescriptor.isEmpty {
            parameters[ParameterConstant.dateDescriptor] = self.dateDescriptor
        }
        parameters[ParameterConstant.APIKey] = KeychainManager.getPublicKey()
        
        let ts = NSDate().timeIntervalSince1970.description
        parameters[ParameterConstant.timestamp] = ts
        parameters[ParameterConstant.hash] = KeychainManager.getHashValue(timestamp: ts)
        super.init(endpoint: .getComicsData, parameters: parameters)
    }
    
}
