//
//  ComicDataTestCases.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 04/05/22.
//

import Foundation
import XCTest
@testable import MarvelData

class ComicDataTestCases: XCTestCase {
    
    var presenter : ComicPresenter?
    let locator = UseCaseLocatorStub()
    let router =  ComicRouterStub()
    let view = ComicViewStub()
    var comicUseCase: ComicDataUseCaseStub?
    
    override func setUp() {
        super.setUp()
        presenter = ComicPresenterImpl(view: view, router: router, locator: locator)
        comicUseCase = locator.getUseCase(ofType: ComicDataUseCase.self) as? ComicDataUseCaseStub
    }
    
    override func tearDown() {
        self.comicUseCase = nil
    }
    
    func test_UseCaseExist() {
        XCTAssertNotNil(comicUseCase)
    }
    
    func test_CharacterResponce() {
        comicUseCase?.getComicsData(pageOffset: 0, sortType: .SortTypeNone) { [weak self] responce, error in
            guard let result = responce else {
                return
            }
            if result.code == 200 {
                XCTAssertEqual(self?.presenter?.getNumberOfRows(), 10)
            }
        }
    }
    
    func test_PaginationResponce() {
        comicUseCase?.getComicsData(pageOffset: 10, sortType: .SortTypeNone) { [weak self] responce, error in
            guard let result = responce else {
                return
            }
            if result.code == 200 {
                XCTAssertEqual(self?.presenter?.getNumberOfRows(), 10)
            }
        }
    }
}
