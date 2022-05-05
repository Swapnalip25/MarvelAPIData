//
//  CharactersDataUsecaseStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import Foundation
@testable import MarvelData

class CharactersDataUsecaseStub: UseCaseImpl, CharactersDataUseCase {
    required init(repository: Repository) {
        super.init(repository: repository)
    }
    
    var apiRepository: APIRepositoryStub {
        return (repository as! APIRepositoryStub)
    }
    
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        return apiRepository.getCharactersData(pageOffset: pageOffset, completion: completion)
    }
}
