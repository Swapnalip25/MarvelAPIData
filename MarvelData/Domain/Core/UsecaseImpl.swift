//
//  UsecaseImpl.swift
//  MarvelData
//
//  Created by Swapnali Patil on 22/04/22.
//

import Foundation

class UseCaseImpl {
    let repository: Repository
    
    required init (repository: Repository) {
        self.repository = repository
    }
}
