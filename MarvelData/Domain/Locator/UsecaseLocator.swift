//
//  UsecaseLocator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 22/04/22.
//

import Foundation

protocol UseCaseLocator {
    func getUseCase<T>(ofType type: T.Type) -> T?
}

class UseCaseLocatorImpl: UseCaseLocator {
    private lazy var apiRepository = APIRepositoryImpl()
    
    func getUseCase<T>(ofType type: T.Type) -> T? {
        switch String(describing: type) {
        case String(describing: CharactersDataUseCase.self):
            return self.buildCharactersDataUseCase() as? T
            
        case String(describing: ComicDataUseCase.self):
            return buildComicDataUseCase() as? T
        default:
            return nil
        }
    }
}

extension UseCaseLocatorImpl {
    func buildCharactersDataUseCase() -> CharactersDataUseCase {
        return CharactersDataUseCaseImpl(repository: self.apiRepository)
    }
    
    func buildComicDataUseCase() -> ComicDataUseCase {
        return ComicDataUseCaseImpl(repository: self.apiRepository)
    }
}
