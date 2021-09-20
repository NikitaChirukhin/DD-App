//
//  DailyCocktailUITests.swift
//  DailyCocktailUITests
//
//  Created by Никита Чирухин on 20.08.2021.
//

import XCTest

class DailyCocktailUITests: XCTestCase {

    
    func test_shouldShouldPushComponentViewSuccessfully() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.cells.firstMatch.tap()
        
        let arrowBackwardCircleFillButton = app.navigationBars["Most Popular"].buttons["arrow.backward.circle.fill"]
        
        XCTAssert(arrowBackwardCircleFillButton.exists)
    }

}
