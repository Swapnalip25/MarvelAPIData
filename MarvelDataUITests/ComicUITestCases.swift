//
//  ComicUITestCases.swift
//  MarvelDataUITests
//
//  Created by Swapnali Patil on 04/05/22.
//

import Foundation
import XCTest

class ComicUITestCases: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func test_checkStaticText() {
        XCTAssert(app.staticTexts["Characters"].exists)
        
        let exp1 = expectation(description: "Test after 10 seconds")
        let result1 = XCTWaiter.wait(for: [exp1], timeout: 10.0)
        if result1 == XCTWaiter.Result.timedOut {
            app.tabBars.buttons["Comics"].tap()
            let exp2 = expectation(description: "Test after 10 seconds")
            let result2 = XCTWaiter.wait(for: [exp2], timeout: 10.0)
            let collectionsQuery = app.collectionViews
            if result2 == XCTWaiter.Result.timedOut {
                XCTAssert(collectionsQuery.cells.staticTexts["Marvel Previews (2017)"].exists)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_openComicsScreen() {
        let app = XCUIApplication()
        let collectionsQuery = app.collectionViews
        
        let exp = expectation(description: "Test after 10 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(collectionsQuery.cells.staticTexts ["3-D Man"].exists)
            app.tabBars.buttons["Comics"].tap()
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
}
