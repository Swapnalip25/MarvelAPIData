//
//  CharactersDataUsecase.swift
//  MarvelData
//
//  Created by Swapnali Patil on 22/04/22.
//

import Foundation

protocol CharactersDataUseCase: UseCase {
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>)
}

class CharactersDataUseCaseImpl: UseCaseImpl, CharactersDataUseCase {
    required init(repository: Repository) {
        super.init(repository: repository)
    }
    
    var apiRepository: APIRepository {
        return (repository as! APIRepository)
    }
    
    func getCharactersData(pageOffset: Int, completion: @escaping ResponseCompletion<CharactersResponce>) {
        return apiRepository.getCharactersData(pageOffset: pageOffset, completion: completion)
    }
}
