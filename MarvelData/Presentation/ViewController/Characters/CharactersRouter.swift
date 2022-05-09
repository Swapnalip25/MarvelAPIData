//
//  CharactersRouter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol CharacterscRouter {
    func navigateToCharacterDetailsScreen(characterData: ResultCharacters)
}

class CharacterscRouterImpl: CharacterscRouter {
    fileprivate weak var viewController: CharactersViewController?

    init(viewController: CharactersViewController) {
        self.viewController = viewController
    }
    
    func navigateToCharacterDetailsScreen(characterData: ResultCharacters) {
        let characterDetailsVC = CharacterDetailsViewController.instantiateFrom(.mainStoryBoard)
        characterDetailsVC.configurator = CharacterDetailsConfiguratorImpl(charactersData: characterData)
        
        self.viewController?.navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}
