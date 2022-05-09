//
//  APIRepositoryStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import Foundation
@testable import MarvelData

class APIRepositoryStub: Repository, APIRepository {
    var apiService = APIServiceStub()
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        apiService.getCharactersData(pageOffset: pageOffset, completion: completion)
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>) {
        apiService.getComicsData(pageOffset: pageOffset, sortType: sortType, completion: completion)
    }    
}
