//
//  CharactersPresenter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol CharactersPresenter {
    func getNumberOfRows() -> Int
    func loadCharactersData()
    func configureCharactersCell(indexpath: IndexPath, cell: CharacterCollectionViewCell)
    func loadPullToRefreshData()
    func setSearchTerm(term: String)
    func isSearchResultActive() -> Bool
    func loadSearchResults()
    func saveSearchHistoryArray(searchString: String)
    func getSearchResult(atIndex index: Int) -> String
    func numberOfSearchResultCount() -> Int
    func filterSearchHistory(searchTerm: String)
}

protocol CharactersOutput: AnyObject {
    func reloadData()
    func paginationDataLoaded()
    func stopLoadingData()
    func showToastMessage(msg: String)
    func reloadSearchHistoryTableView()
    func openSearchHistoryView()
    func closeSearchHistory()
}

class CharactersPresenterImpl: CharactersPresenter {
    private var view: CharactersOutput
    private var router: CharacterscRouter
    private var useCaseLocator: UseCaseLocator
    private var usecase: CharactersDataUseCase
    private var charactersArray: [ResultCharacters] = []
    private var searchResultCharactersArray: [ResultCharacters] = []
    private var searchResultHistoryArray: [String] = []
    var isSearchEnabled: Bool = false
    let defaults = UserDefaults.standard
    var searchHistoryArray: [String] = []
    var searchText: String = "" {
        willSet(newValue) {
            if newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                isSearchEnabled = false
                view.reloadData()
            } else {
                isSearchEnabled = true
                filterData(searchTerm: newValue)
                filterSearchHistory(searchTerm: newValue)
            }
    
        }
    }
    
    init(view: CharactersOutput, router: CharacterscRouter, locator: UseCaseLocator) {
        self.view = view
        self.router = router
        self.useCaseLocator = locator
        self.usecase = locator.getUseCase(ofType: CharactersDataUseCase.self)!
        self.loadSearchResults()
    }
    
    func loadCharactersData() {
        if !NetworkManager.sharedInstance.isRechable {
            self.view.showToastMessage(msg: NetworkErrorMessage.strNoInternetConnection)
            return
        }
        
        self.activityStartAnimating()
        self.usecase.getCharactersData(pageOffset: 0) { [weak self] responce, error in
            guard let result = responce else{
                self?.view.showToastMessage(msg: AppError.errAPIFailure)
                self?.hideActivityIndicator()
                return
            }
            if result.code == AppResponceCode.successCode {
                self?.hideActivityIndicator()
                self?.charactersArray  = result.data.results
                self?.view.reloadData()
            }
        }
    }
    
    func loadPullToRefreshData() {
        if !NetworkManager.sharedInstance.isRechable {
            self.view.showToastMessage(msg: NetworkErrorMessage.strNoInternetConnection)
            return
        }
        
        self.usecase.getCharactersData(pageOffset: self.charactersArray.count) { [weak self] responce, error in
            guard let result = responce else{
                self?.view.showToastMessage(msg: AppError.errAPIFailure)
                self?.hideActivityIndicator()
                return
            }
            if result.code == AppResponceCode.successCode {
                self?.charactersArray.append(contentsOf: result.data.results)
                self?.view.paginationDataLoaded()
                //Stop loading data once you have all data loaded on UI
                if self?.charactersArray.count == result.data.total {
                    self?.view.stopLoadingData()
                }
                self?.view.reloadData()
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return isSearchEnabled ? searchResultCharactersArray.count : charactersArray.count
    }
    
    func configureCharactersCell(indexpath: IndexPath, cell: CharacterCollectionViewCell) {
        if let result = isSearchEnabled ? searchResultCharactersArray[safe: indexpath.row] : charactersArray[safe: indexpath.row] {
            cell.configureCharactersData(result: result)
        }
    }
}

//MARK:- Search related functions
extension CharactersPresenterImpl {
    func isSearchResultActive() -> Bool {
        return isSearchEnabled
    }
    
    func setSearchTerm(term: String) {
        self.searchText = term
    }
    
    private func filterData(searchTerm: String) {
        searchResultCharactersArray = charactersArray.filter({ character in
            return character.name.lowercased().contains(searchTerm.lowercased())
        })
        self.view.reloadData()
    }
}

//MARK:- Activity Indicator Methods
extension CharactersPresenterImpl {
    func activityStartAnimating() {
        ActivityIndicator.activityStartAnimating()
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.activityStopAnimating()
    }
}

//MARK:- User Search History Methods
extension CharactersPresenterImpl {
    func loadSearchResults() {
        searchHistoryArray = defaults.stringArray(forKey: UserDefaultConstant.searchHistoryKey) ?? [String]()
        self.view.reloadSearchHistoryTableView()
    }
    
    func saveSearchHistoryArray(searchString: String) {
        if !searchString.isEmpty  && !self.searchHistoryArray.contains(searchString) {
            self.searchHistoryArray.insert(searchString, at: 0)
            defaults.set(Array(self.searchHistoryArray.prefix(10)), forKey: UserDefaultConstant.searchHistoryKey) //Save only 10 max values in userDefaults for search history
            defaults.synchronize()
        }
    }
    
    func getSearchResult(atIndex index: Int) -> String {
        return isSearchEnabled ? searchResultHistoryArray[safe: index] ?? "" : searchHistoryArray[safe: index] ?? ""
    }
    
    func numberOfSearchResultCount() -> Int {
        return isSearchEnabled ? searchResultHistoryArray.count : searchHistoryArray.count
    }
    
    func filterSearchHistory(searchTerm: String) {
        searchResultHistoryArray = searchHistoryArray.filter({ searchHistory in
            return searchHistory.lowercased().contains(searchTerm.lowercased())
        })
        
        if searchResultHistoryArray.isEmpty {
            self.view.closeSearchHistory()
        }
        
        self.view.reloadSearchHistoryTableView()
    }
}
