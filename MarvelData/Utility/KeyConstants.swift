//
//  KeyConstants.swift
//  MarvelData
//
//  Created by Swapnali Patil on 02/05/22.
//

import Foundation

//MARK:- ComicViewController constants
struct ComicsViewControllerConstants {
    static let screenTitle = "Comics"
    static let cellIdentifier = "ComicCollectionViewCell"
    static let sortNone = "All Comics"
    static let sortLastWeek = "Sort By Last Week"
    static let sortThisWeek = "Sort By This Week"
    static let sortNextWeek = "Sort By Next Week"
    static let sortThisMonth = "Sort By This Month"
    static let cancel = "Cancel"
}

//MARK:- CharactersViewController constants
struct CharactersViewControllerConstants {
    static var screenTitle = "Characters"
    static var cellIdentifier = "CharacterCollectionViewCell"
}

//MARK:- Cell Constants
struct CellConstants {
    static var imageExtension = ".jpg"
    static var placeholderImage = "Placeholder"
    static var httpsScheme = "https"
}

//MARK:- Network Messages
struct NetworkErrorMessage {
    static var strNoInternetConnection = "No internet connection. Please try again once internet is reachable."
}

//MARK:- UserDefaults Constants
struct UserDefaultConstant {
    static let searchHistoryKey = "SearchHistoryData"
}

struct AppError {
    static let errAPIFailure = "Failed to load data. Please try again"
}

struct AppResponceCode {
    static let successCode = 200
}
