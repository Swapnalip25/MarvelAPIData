//
//  ComicsRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol ComicRouter {
    func navigateToComicDetailsScreen(comicData: ResultComic)
}

class ComicRouterImpl: ComicRouter {
    fileprivate weak var viewController: ComicsViewController?

    init(viewController: ComicsViewController) {
        self.viewController = viewController
    }
    
    func navigateToComicDetailsScreen(comicData: ResultComic) {
        let comicDetailsVC = ComicDetailsViewController.instantiateFrom(.mainStoryBoard)
        comicDetailsVC.configurator = ComicDetailsConfiguratorImpl(comicData: comicData)
        
        self.viewController?.navigationController?.pushViewController(comicDetailsVC, animated: true)
    }
}
