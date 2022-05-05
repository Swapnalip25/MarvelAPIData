//
//  CharacterDetailsPresenter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol CharacterDetailsPresenter {
    func getCharactersData() -> ResultCharacters?
}

protocol CharacterDetailsOutput: AnyObject {
    func loadDataOnUI()
}

class CharacterDetailsPresenterImpl: CharacterDetailsPresenter {
    private var view: CharacterDetailsOutput
    private var router: CharacterDetailsRouter
    private var charactersData: ResultCharacters?
    
    init(view: CharacterDetailsOutput, router: CharacterDetailsRouter, charactersData: ResultCharacters?) {
        self.view = view
        self.router = router
        self.charactersData = charactersData
    }
    
    func getCharactersData() -> ResultCharacters? {
        return self.charactersData
    }
}
