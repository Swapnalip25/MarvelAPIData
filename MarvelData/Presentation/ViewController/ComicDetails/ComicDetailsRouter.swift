//
//  ComicDetailsRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol ComicDetailsRouter {
   
}

class ComicDetailsRouterImpl: ComicDetailsRouter {
    fileprivate weak var viewController: ComicDetailsViewController?

    init(viewController: ComicDetailsViewController) {
        self.viewController = viewController
    }
}
