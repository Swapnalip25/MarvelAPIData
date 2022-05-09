//
//  ViewUtility.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import Foundation
import UIKit
/**
 This class provides access to viewControllers linked in storyboard
 */

protocol StoryboardProvider: AnyObject {
    static var identifier: String { get }
}

extension StoryboardProvider {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardProvider where Self: UIViewController {
    static func instantiateFrom(_ storyboard: StoryBoard) -> Self {
        guard let viewController = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("The viewController of identifier '\(storyboard.rawValue)' was not found!")
        }
        return viewController
    }
}

extension UIViewController: StoryboardProvider { }

enum StoryBoard: String {
    case mainStoryBoard = "Main"
}

private struct StoryboardConstants {
    static let mainStoryBoard = "Main"
    static let characterDetailsNavigation = "CharacterDetailsViewController"
    static let comicDetailsNavigation = "ComicDetailsViewController"
}

func getStoryboard(name:String) -> UIStoryboard {
    return UIStoryboard(name: name, bundle: nil)
}

func getCharacterDetailsViewController() -> UIViewController? {
    let rootViewController = getStoryboard(name: StoryboardConstants.mainStoryBoard).instantiateViewController(withIdentifier: StoryboardConstants.characterDetailsNavigation)
    
    return rootViewController
}

func getComicDetailsViewController() -> UIViewController? {
    let vc = getStoryboard(name: StoryboardConstants.mainStoryBoard).instantiateViewController(identifier: StoryboardConstants.comicDetailsNavigation)
    return vc
}
