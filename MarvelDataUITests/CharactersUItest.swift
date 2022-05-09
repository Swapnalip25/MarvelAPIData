//
//  CharactersUItest.swift
//  MarvelDataUITests
//
//  Created by Swapnali Patil on 04/05/22.
//

import Foundation
import XCTest

class CharactersUItestCases: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func test_checkStaticText() {
        XCTAssert(app.staticTexts["Characters"].exists)
        XCTAssert(app.staticTexts["Search Character"].exists)
        XCTAssert(app.staticTexts["Cancel"].exists)
    }
    
    func test_cellData() {
        let app = XCUIApplication()
        let collectionsQuery = app.collectionViews
        
        let exp = expectation(description: "Test after 10 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(collectionsQuery.cells.staticTexts ["3-D Man"].exists)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_CheckSearchBarPresent() {
        var searchField: XCUIElement { app.searchFields["searchField"] }
        XCTAssert(searchField.exists)
    }
}
