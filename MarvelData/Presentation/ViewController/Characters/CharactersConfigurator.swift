//
//  CharactersConfigurator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol CharactersConfigurator {
    func configure(charactersViewController: CharactersViewController)
}

class CharactersConfiguratorImpl: CharactersConfigurator {
    func configure(charactersViewController: CharactersViewController) {
        let locator = UseCaseLocatorImpl()
        let router = CharacterscRouterImpl(viewController: charactersViewController)
        let presenter = CharactersPresenterImpl(view: charactersViewController, router: router, locator: locator)
        charactersViewController.presenter = presenter
    }
}
