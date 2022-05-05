//
//  CharacterDetailsConfigurator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation

protocol CharacterDetailsConfigurator {
    func configure(characterDetailsViewController: CharacterDetailsViewController)
}

class CharacterDetailsConfiguratorImpl: CharacterDetailsConfigurator {
    let charactersData: ResultCharacters?
    
    init(charactersData: ResultCharacters) {
        self.charactersData = charactersData
    }
    
    func configure(characterDetailsViewController: CharacterDetailsViewController) {
        let router = CharacterDetailsRouterImpl(viewController: characterDetailsViewController)
        let presenter = CharacterDetailsPresenterImpl(view: characterDetailsViewController, router: router, charactersData: self.charactersData)
        characterDetailsViewController.presenter = presenter
    }
}
