//
//  ComicsPresenter.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

protocol ComicPresenter {
    func viewWillAppear()
    func getNumberOfRows() -> Int
    func loadComicsData()
    func configureComicCell(indexpath: IndexPath, cell: ComicCollectionViewCell)
    func activityStartAnimating()
    func hideActivityIndicator()
    func setSearchTerm(term: String)
    func isSearchResultActive() -> Bool
    func loadPullToRefreshData()
    func getSortingType() -> SortType
    func sortModulesBy(type: SortType)
    func navigateToComicDetailsScreen(index: Int)
}

protocol ComicOutput: AnyObject {
    func reloadData()
    func showToastMessage(msg: String)
    func paginationDataLoaded()
    func stopLoadingData(isLoaded: Bool)
}

enum SortType {
    case SortTypeNone
    case SortTypeLastWeek
    case SortTypeThisWeek
    case SortTypeNextWeek
    case SortTypeThisMonth
}

class ComicPresenterImpl: ComicPresenter {
    private var view: ComicOutput
    private var router: ComicRouter
    private var useCaseLocator: UseCaseLocator
    private var usecase: ComicDataUseCase?
    private var comicArray: [ResultComic] = []
    private var searchResultComicArray: [ResultComic] = []
    var isSearchEnabled: Bool = false
    var searchText: String = "" {
        willSet(newValue) {
            if newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                isSearchEnabled = false
                view.reloadData()
            } else {
                isSearchEnabled = true
                filterData(searchTerm: newValue)
            }
    
        }
    }
    private var sortingType: SortType = .SortTypeNone
    
    
    init(view: ComicOutput, router: ComicRouter, locator: UseCaseLocator) {
        self.view = view
        self.router = router
        self.useCaseLocator = locator
        self.usecase = locator.getUseCase(ofType: ComicDataUseCase.self)
        self.sortingType = .SortTypeNone
    }
    
    func viewWillAppear() {
        
    }
    
    func loadComicsData() {
        if !NetworkManager.sharedInstance.isRechable {
            self.view.showToastMessage(msg: NetworkErrorMessage.strNoInternetConnection)
            return
        }
        self.activityStartAnimating()
        self.usecase?.getComicsData(pageOffset: 0, sortType: self.sortingType) { [weak self] responce, error in
            guard let result = responce else {
                self?.view.showToastMessage(msg: AppError.errAPIFailure)
                self?.hideActivityIndicator()
                return
            }
            if result.code == AppResponceCode.successCode {
                self?.hideActivityIndicator()
                self?.comicArray = result.data.results
                self?.view.reloadData()
            }
        }
    }
    
    func loadPullToRefreshData() {
        if !NetworkManager.sharedInstance.isRechable {
            self.view.showToastMessage(msg: NetworkErrorMessage.strNoInternetConnection)
            return
        }
        self.usecase?.getComicsData(pageOffset: self.comicArray.count, sortType: self.sortingType) { [weak self] responce, error in
            guard let result = responce else {
                self?.view.showToastMessage(msg: AppError.errAPIFailure)
                self?.hideActivityIndicator()
                return
            }
            if result.code == AppResponceCode.successCode {
                self?.comicArray.append(contentsOf: result.data.results)
                self?.view.paginationDataLoaded()
                //Stop loading data once you have all data loaded on UI
                if self?.comicArray.count == result.data.total {
                    self?.view.stopLoadingData(isLoaded: true)
                }
                self?.view.reloadData()
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return isSearchEnabled ? searchResultComicArray.count : comicArray.count
    }
    
    func configureComicCell(indexpath: IndexPath, cell: ComicCollectionViewCell) {
        if let result = isSearchEnabled ? searchResultComicArray[safe: indexpath.row] : self.comicArray[safe: indexpath.row] {
            cell.configureComicData(result: result)
        }
    }
    
    func navigateToComicDetailsScreen(index: Int) {
        if let result = isSearchEnabled ? searchResultComicArray[safe: index] : self.comicArray[safe: index] {
            self.router.navigateToComicDetailsScreen(comicData: result)
        }
    }
}

//MARK:- Sorting Data
extension ComicPresenterImpl {
    func getSortingType() -> SortType {
        return sortingType
    }
    
    func sortModulesBy(type: SortType) {
        self.sortingType = type
        self.view.stopLoadingData(isLoaded: false)
        self.comicArray = []
        self.loadPullToRefreshData()
    }
}

//MARK:- Search related functions
extension ComicPresenterImpl {
    func isSearchResultActive() -> Bool {
        return isSearchEnabled
    }
    
    func setSearchTerm(term: String) {
        self.searchText = term
    }
    
    private func filterData(searchTerm: String) {
        searchResultComicArray = comicArray.filter({ comic in
            return comic.title.lowercased().contains(searchTerm.lowercased())
        })
        self.view.reloadData()
    }
}

//MARK:- Activity Indicator
extension ComicPresenterImpl {
    func activityStartAnimating() {
        ActivityIndicator.activityStartAnimating()
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.activityStopAnimating()
    }
}
