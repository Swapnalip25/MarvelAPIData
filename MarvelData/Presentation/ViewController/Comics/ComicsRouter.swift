//
//  ComicsRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol ComicRouter {
    
}

class ComicRouterImpl: ComicRouter {
    fileprivate weak var viewController: ComicsViewController?

    init(viewController: ComicsViewController) {
        self.viewController = viewController
    }
}
