//
//  ComicDataUsecaseStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 04/05/22.
//

import Foundation
@testable import MarvelData

class ComicDataUseCaseStub: UseCaseImpl, ComicDataUseCase {
    required init(repository: Repository) {
        super.init(repository: repository)
    }
    
    var apiRepository: APIRepositoryStub {
        return (repository as! APIRepositoryStub)
    }
    
    func getComicsData(pageOffset: Int, sortType: SortType, completion: @escaping ResponseCompletion<ComicResponce>) {
        return apiRepository.getComicsData(pageOffset: pageOffset, sortType: sortType, completion: completion)
    }
}

