//
//  APIServices.swift
//  MarvelData
//
//  Created by Swapnali Patil on 20/04/22.
//

import Foundation
import Alamofire

typealias ResponseCompletion<T: Decodable> = (T?, _ error: Error?) -> Void

protocol APIService { }

class APIManager {
    static let shared = APIManager()
    
    typealias APIResult = Result
    
    let sessionManager: Session = {
        // Create a shared URL cache
        let memoryCapacity = 500 * 1024 * 1024; // 500 MB
        let diskCapacity = 500 * 1024 * 1024; // 500 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "shared_cache")
        
        
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        configuration.urlCache = cache
//        let responseCacher = ResponseCacher(behavior: .modify { _, response in
//            let userInfo = ["date": Date()]
//            return CachedURLResponse(
//                response: response.response,
//                data: response.data,
//                userInfo: userInfo,
//                storagePolicy: .allowed)
//        })
        
        let networkLogger = NetworkLogger()
        
        return Session(
            configuration: configuration,
           // cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        let request = CharactersDataRequest(limit: 10, offset: pageOffset)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        sessionManager.request(request)
            .validate()
            .responseDecodable(of: CharactersResponce.self, decoder: decoder) {responce in
                debugPrint(responce)
                switch responce.result {
                case .success(_):
                    completion(responce.value, nil)
                case .failure(let error):
                    completion(nil,error)
                }
            }
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>) {
        let request = ComicsDataRequest(limit: 10, offset: pageOffset, type: sortType)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        sessionManager.request(request)
            .validate()
            .responseDecodable(of: ComicResponce.self, decoder: decoder) {responce in
                debugPrint(responce)
                switch responce.result {
                case .success(_):
                    completion(responce.value, nil)
                case .failure(let error):
                    completion(nil,error)
                }
            }
    }
}

protocol ApiRequestProtocol: URLRequestConvertible {
    
}

class ApiRequest: ApiRequestProtocol {
    
    let endpoint: Endpoint
    let method: HTTPRequestMethod
    let parameters: [String : Any]
    var queryEncoding: Bool {
        return false
    }
    
    init(endpoint: Endpoint, method: HTTPRequestMethod = .get, parameters: [String:Any]) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try endpoint.completeUrl().asURL()
        let cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
//        if !NetworkManager.sharedInstance.isRechable {
//            cachePolicy = .returnCacheDataDontLoad
//        }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 100)
        request.httpMethod = method.rawValue
        if (self.queryEncoding){
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        }
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
