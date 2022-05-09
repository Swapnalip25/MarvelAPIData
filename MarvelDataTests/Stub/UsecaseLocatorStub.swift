//
//  UsecaseLocatorStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import Foundation
@testable import MarvelData

class UseCaseLocatorStub: UseCaseLocator {
    private  var charactersDataUsecase: CharactersDataUsecaseStub?

    var repository: Repository {
        return APIRepositoryStub() as Repository
    }
    func getUseCase<T>(ofType type: T.Type) -> T? {
        switch String(describing:type) {
        case String(describing: CharactersDataUseCase.self):
            return buildUseCase(type: CharactersDataUsecaseStub.self)
            
        case String(describing: ComicDataUseCase.self):
            return buildUseCase(type: ComicDataUseCaseStub.self)
        default:
            return nil
        }
        
    }
    
}
extension UseCaseLocatorStub{
    func buildUseCase<U:UseCaseImpl,R>(type:U.Type) -> R?{
        return U(repository: repository) as? R
    }
}
