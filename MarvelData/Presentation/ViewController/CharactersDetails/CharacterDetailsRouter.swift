//
//  CharacterDetailsRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol CharacterDetailsRouter {
   
}

class CharacterDetailsRouterImpl: CharacterDetailsRouter {
    fileprivate weak var viewController: CharacterDetailsViewController?

    init(viewController: CharacterDetailsViewController) {
        self.viewController = viewController
    }
}
