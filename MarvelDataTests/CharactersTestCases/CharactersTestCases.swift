//
//  CharactersTestCases.swift
//  MarvelDataTests
//
//  Created by Swapnali Patil on 03/05/22.
//

import XCTest
@testable import MarvelData

class CharactersTestCases: XCTestCase {
    
    var presenter : CharactersPresenter?
    let locator = UseCaseLocatorStub()
    let router =  CharactersRouterStub()
    let view = CharactersViewStub()
    var charactersUseCase: CharactersDataUsecaseStub?
    
    override func setUp() {
        super.setUp()
        presenter = CharactersPresenterImpl(view: view, router: router, locator: locator)
        charactersUseCase = locator.getUseCase(ofType: CharactersDataUseCase.self) as? CharactersDataUsecaseStub
    }
    
    override func tearDown() {
        self.charactersUseCase = nil
    }
    
    func test_UseCaseExist() {
        XCTAssertNotNil(locator.getUseCase(ofType: CharactersDataUseCase.self))
    }
    
    func test_CharacterResponce() {
        charactersUseCase?.getCharactersData(pageOffset: 0) { [weak self] responce, error in
            guard let result = responce else{
                return
            }
            if result.code == 200 {
                XCTAssertEqual(self?.presenter?.getNumberOfRows(), 10)
            }
        }
    }
    
    func test_PaginationResponce() {
        let usecase = locator.getUseCase(ofType: CharactersDataUseCase.self)!
        usecase.getCharactersData(pageOffset: 10) { [weak self] responce, error in
            guard let result = responce else{
                return
            }
            if result.code == 200 {
                XCTAssertEqual(self?.presenter?.getNumberOfRows(), 10)
            }
        }
    }
    
}
