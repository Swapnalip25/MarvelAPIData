//
//  CharactersViewController.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import UIKit
import SDWebImage

class CharactersViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter : CharactersPresenter?
    var configurator : CharactersConfigurator?
    private var loadingData = false
    private var isAllDataLoaded = false
    var searchTask: DispatchWorkItem?
    let font = UIFont.systemFont(ofSize: 15.0)
    let minimumSpacingConstant: CGFloat = 5.0
    let edgeInsetConstant: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let configurator = CharactersConfiguratorImpl()
        configurator.configure(charactersViewController: self)
        self.title = CharactersViewControllerConstants.screenTitle
        self.collectionView.register(UINib.init(nibName: CharactersViewControllerConstants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CharactersViewControllerConstants.cellIdentifier)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presenter?.loadCharactersData()
        }
        setUpCollectionFlowLayout()
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func setUpCollectionFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = minimumSpacingConstant
        layout.minimumInteritemSpacing = minimumSpacingConstant
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter?.getNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInsetConstant, left: edgeInsetConstant, bottom: edgeInsetConstant, right: edgeInsetConstant)
    }

    //220 300
    // screenwidth ?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = (collectionView.frame.width - 20) / 2 - lay.minimumInteritemSpacing
        
        let calculatedHeight = ((collectionView.frame.width - 20) * 220) / 305
        return CGSize(width:widthPerItem, height: calculatedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: CharacterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersViewControllerConstants.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell  {
            presenter?.configureCharactersCell(indexpath: indexPath, cell: cell)
            return cell
        }
        return UICollectionViewCell()
    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.navigateToDetailsScreen(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if !(self.presenter?.isSearchResultActive() ?? true) && !loadingData && !isAllDataLoaded && offsetY > contentHeight - scrollView.frame.size.height {
            loadingData = true
            self.presenter?.loadPullToRefreshData()
        }
    }
}

//MARK:- Charaters Output protocol Methods
extension CharactersViewController: CharactersOutput {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func paginationDataLoaded() {
        self.loadingData = false
    }
    
    func stopLoadingData() {
        self.isAllDataLoaded = true
    }
    
    func showToastMessage(msg: String) {
        self.showToast(message: msg, font: font)
    }
}

//MARK:- Search Bar delegate Methods
extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchResult(searchText: searchText)
    }
    
    func searchResult(searchText: String) {
        self.searchTask?.cancel()

        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                //Use search text and perform the query
                DispatchQueue.main.async {
                    self?.presenter?.setSearchTerm(term: searchText)
                    if searchText == "" {
                        self?.searchBar.endEditing(true)
                    }
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.saveSearchResult(searchText: searchBar.text ?? "")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.openSearchHistoryView()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.setSearchTerm(term: "")
        self.searchBar.text = ""
        self.closeSearchHistory()
        self.searchBar.endEditing(true)
    }
}

//MARK:- Tableview delegate and Datasource
extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfSearchResultCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.presenter?.getSearchResult(atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        self.searchBar.text = self.presenter?.getSearchResult(atIndex: indexPath.row)
        self.searchResult(searchText: self.searchBar.text ?? "")
        closeSearchHistory()
    }
}


extension CharactersViewController {
    func saveSearchResult(searchText: String) {
        self.presenter?.saveSearchHistoryArray(searchString: searchText)
    }
    
    func openSearchHistoryView() {
        self.presenter?.loadSearchResults()
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
    }
    
    func closeSearchHistory() {
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
    }
    
    func reloadSearchHistoryTableView() {
        self.tableView.reloadData()
    }
}
