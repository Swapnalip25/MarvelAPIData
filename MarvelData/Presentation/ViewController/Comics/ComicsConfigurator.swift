//
//  ComicsConfigurator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol ComicConfigurator {
    func configure(comicViewController: ComicsViewController)
}

class ComicConfiguratorImpl: ComicConfigurator {
    func configure(comicViewController: ComicsViewController) {
        let locator = UseCaseLocatorImpl()
        let router = ComicRouterImpl(viewController: comicViewController)
        let presenter = ComicPresenterImpl(view: comicViewController, router: router, locator: locator)
        comicViewController.presenter = presenter
    }
}
