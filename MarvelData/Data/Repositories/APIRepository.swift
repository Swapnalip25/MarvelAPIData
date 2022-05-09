//
//  APIRepository.swift
//  MarvelData
//
//  Created by Swapnali Patil on 23/04/22.
//

import Foundation

protocol APIRepository {
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>)
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>)
}

class APIRepositoryImpl: Repository, APIRepository {
    lazy var apiServices : APIManager = APIManager.shared
    
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        return apiServices.getCharactersData(pageOffset: pageOffset, completion: completion)
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>) {
        return apiServices.getComicsData(pageOffset: pageOffset, sortType: sortType, completion: completion)
    }
}
