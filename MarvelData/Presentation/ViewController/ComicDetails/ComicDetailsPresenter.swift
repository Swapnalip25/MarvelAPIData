//
//  ComicDetailsPresenter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol ComicDetailsPresenter {
    func getComicData() -> ResultComic?
}

protocol ComicDetailsOutput: AnyObject {
    func loadDataOnUI()
}

class ComicDetailsPresenterImpl: ComicDetailsPresenter {
    private var view: ComicDetailsOutput
    private var router: ComicDetailsRouter
    private var comicData: ResultComic?
    
    init(view: ComicDetailsOutput, router: ComicDetailsRouter, comicData: ResultComic?) {
        self.view = view
        self.router = router
        self.comicData = comicData
    }
    
    func getComicData() -> ResultComic? {
        return self.comicData
    }
}
