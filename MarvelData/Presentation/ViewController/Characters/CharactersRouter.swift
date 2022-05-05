//
//  CharactersRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol CharacterscRouter {
    
}

class CharacterscRouterImpl: CharacterscRouter {
    fileprivate weak var viewController: CharactersViewController?

    init(viewController: CharactersViewController) {
        self.viewController = viewController
    }
}
