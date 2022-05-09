//
//  ComicsDataUsecase.swift
//  MarvelData
//
//  Created by Swapnali Patil on 22/04/22.
//

import Foundation

protocol ComicDataUseCase: UseCase {
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>)
}

class ComicDataUseCaseImpl: UseCaseImpl, ComicDataUseCase {
    required init(repository: Repository) {
        super.init(repository: repository)
    }
    
    var apiRepository: APIRepository {
        return (repository as! APIRepository)
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>) {
        return apiRepository.getComicsData(pageOffset: pageOffset, sortType: sortType, completion: completion)
    }
}

