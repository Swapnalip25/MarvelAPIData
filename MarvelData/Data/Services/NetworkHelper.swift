//
//  NetworkHelper.swift
//  MarvelData
//
//  Created by Swapnali Patil on 20/04/22.
//

import Foundation
import CryptoKit

enum HTTPRequestMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

enum Endpoint: String {
    private var baseURL: String {
        return "https://gateway.marvel.com:443/v1/public/"
    }
    
    case getCharactersData = "characters"
    case getComicsData = "comics"

    func completeUrl() -> String {
        return "\(baseURL)\(self.rawValue)"
    }
}

enum ParameterConstant {
    static let limit = "limit"
    static let offset = "offset"
    static let nameStartsWith = "nameStartsWith"
    static let modifiedSince = "modifiedSince"
    static let orderBy = "orderBy"
    static let DevId = "devId"
    static let sysSecToken = "sysSecToken"
    static let APIKey = "apikey"
    static let hash = "hash"
    static let timestamp = "ts"
    static let dateDescriptor = "dateDescriptor"
    
    static func getDateDescriptorString(type: SortType) -> String {
        switch type {
        case .SortTypeThisWeek:
            return "thisWeek"
        case .SortTypeLastWeek:
            return "lastWeek"
        case .SortTypeNextWeek:
            return "nextWeek"
        case .SortTypeThisMonth:
            return "thisMonth"
        default:
            return ""
        }
    }
}
