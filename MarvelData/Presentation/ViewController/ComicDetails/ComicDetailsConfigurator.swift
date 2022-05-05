//
//  ComicDetailsConfigurator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol ComicDetailsConfigurator {
    func configure(comicDetailsViewController: ComicDetailsViewController)
}

class ComicDetailsConfiguratorImpl: ComicDetailsConfigurator {
    let comicData: ResultComic?
    
    init(comicData: ResultComic) {
        self.comicData = comicData
    }
    
    func configure(comicDetailsViewController: ComicDetailsViewController) {
        let router = ComicDetailsRouterImpl(viewController: comicDetailsViewController)
        let presenter = ComicDetailsPresenterImpl(view: comicDetailsViewController, router: router, comicData: self.comicData)
        comicDetailsViewController.presenter = presenter
    }
}
