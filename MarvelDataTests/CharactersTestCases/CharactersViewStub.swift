//
//  CharactersViewStub.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import Foundation
import UIKit
@testable import MarvelData

class CharactersViewStub: UIViewController, CharactersOutput {    
    var collectionDataReloaded = false
    func reloadData() {
        collectionDataReloaded =  true
    }
    
    func paginationDataLoaded() {
        
    }
    
    func stopLoadingData() {
        
    }
    
    func showToastMessage(msg: String) {
        
    }
    
    func reloadSearchHistoryTableView() {
        
    }
    
    func openSearchHistoryView() {
        
    }
    
    func closeSearchHistory() {
        
    }    
}
