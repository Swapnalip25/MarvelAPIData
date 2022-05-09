//
//  ComicsViewController.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import UIKit
import SDWebImage

class ComicsViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var filterButton: UIButton!
    
    private var loadingData = false
    private var isAllDataLoaded = false
    var presenter: ComicPresenter?
    var configurator: ComicConfigurator?
    private var searchTask: DispatchWorkItem?
    private let minimumSpacingConstant: CGFloat = 5.0
    private let edgeInsetConstant: CGFloat = 10.0
    private let fontSize = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator = ComicConfiguratorImpl()
        configurator?.configure(comicViewController: self)
        self.title = ComicsViewControllerConstants.screenTitle
        self.collectionView.register(UINib.init(nibName: ComicsViewControllerConstants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ComicsViewControllerConstants.cellIdentifier)
        
        self.presenter?.loadComicsData()
        self.setUpCollectionFlowLayout()
    }
    
    func setUpCollectionFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = minimumSpacingConstant
        layout.minimumInteritemSpacing = minimumSpacingConstant
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func filterButtonAction(_ sender: Any?) {
        //show actionsheet with filter options
        
        let actionView : UIAlertController = UIAlertController()
        //actionView.view.tintColor = UIColor.green
        
        let currentSortType = presenter?.getSortingType()
        
        //All comics
        let sortNone = ComicsViewControllerConstants.sortNone
        let filterNone = UIAlertAction(title: sortNone, style: UIAlertAction.Style.default) { (_) in
            self.presenter?.sortModulesBy(type: .SortTypeNone)
        }
        filterNone.isEnabled = currentSortType != .SortTypeNone
        actionView.addAction(filterNone)
        
        //Last week
        let sortLastWeek = ComicsViewControllerConstants.sortLastWeek
        let filterLastWeek = UIAlertAction(title: sortLastWeek, style: UIAlertAction.Style.default) { (_) in
            self.presenter?.sortModulesBy(type: .SortTypeLastWeek)
        }
        filterLastWeek.isEnabled = currentSortType != .SortTypeLastWeek
        actionView.addAction(filterLastWeek)

        //This week
        let sortThisWeek = ComicsViewControllerConstants.sortThisWeek
        let filterThisWeek = UIAlertAction(title: sortThisWeek, style: UIAlertAction.Style.default) { (_) in
            self.presenter?.sortModulesBy(type: .SortTypeThisWeek)
        }
        filterThisWeek.isEnabled = currentSortType != .SortTypeThisWeek
        actionView.addAction(filterThisWeek)
        
        //Next week
        let sortNextWeek = ComicsViewControllerConstants.sortNextWeek
        let filterNextWeek = UIAlertAction(title: sortNextWeek, style: UIAlertAction.Style.default) { (_) in
            self.presenter?.sortModulesBy(type: .SortTypeNextWeek)
        }
        filterNextWeek.isEnabled = currentSortType != .SortTypeNextWeek
        actionView.addAction(filterNextWeek)
        
        //Next week
        let sortThisMonth = ComicsViewControllerConstants.sortThisMonth
        let filterThisMonth = UIAlertAction(title: sortThisMonth, style: UIAlertAction.Style.default) { (_) in
            self.presenter?.sortModulesBy(type: .SortTypeThisMonth)
        }
        filterThisMonth.isEnabled = currentSortType != .SortTypeThisMonth
        actionView.addAction(filterThisMonth)

        
        let cancelAction = UIAlertAction(title: ComicsViewControllerConstants.cancel, style: UIAlertAction.Style.cancel) { (_) in
            
        }
        actionView.addAction(cancelAction)
        self.present(actionView, animated: true, completion: nil)
    }

}

//MARK:- Collection View Delegate and Datasource
extension ComicsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        
        let calculatedHeight = ((collectionView.frame.width - 20) * 220) / 295
        return CGSize(width:widthPerItem, height: calculatedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ComicCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsViewControllerConstants.cellIdentifier, for: indexPath) as? ComicCollectionViewCell  {
            presenter?.configureComicCell(indexpath: indexPath, cell: cell)
            return cell
        }
        return UICollectionViewCell()
    }
           
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.navigateToComicDetailsScreen(index: indexPath.row)
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

//MARK:- Search Bar delegate Methods
extension ComicsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
    }
}

//MARK:- Comic Output
extension ComicsViewController: ComicOutput {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func showToastMessage(msg: String) {
        self.showToast(message: msg, font: UIFont.systemFont(ofSize: CGFloat(fontSize)))
    }
    
    func paginationDataLoaded() {
        self.loadingData = false
    }
    
    func stopLoadingData(isLoaded: Bool) {
        self.isAllDataLoaded = isLoaded
    }
}
