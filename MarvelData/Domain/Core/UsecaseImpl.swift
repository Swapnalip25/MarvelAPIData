//
//  UsecaseImpl.swift
//  MarvelData
//
//  Created by Swapnali Patil on 22/04/22.
//

import Foundation

typealias CompletionClosure<T> = (Result<T>) -> Void


class UseCaseImpl{
    var repository: Repository
    
    required init (repository:Repository){
        self.repository = repository
    }
}
