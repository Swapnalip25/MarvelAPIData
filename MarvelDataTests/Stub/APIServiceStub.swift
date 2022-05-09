//
//  APIServiceStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import Foundation
@testable import MarvelData

class APIServiceStub {
    
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        APIManager.shared.getCharactersData(pageOffset: pageOffset, completion: completion)
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>)  {
        APIManager.shared.getComicsData(pageOffset: pageOffset, sortType: sortType, completion: completion)
    }
}
