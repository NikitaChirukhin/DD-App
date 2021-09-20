//
//  DailyCocktailUITests.swift
//  DailyCocktailUITests
//
//  Created by Никита Чирухин on 20.08.2021.
//

import XCTest

class DailyCocktailUITests: XCTestCase {

    var application: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        application = XCUIApplication()
        application.launch()
    }
    
    override func tearDownWithError() throws {
        application = nil
        try super.tearDownWithError()
    }
    
    func test_shouldShouldPushComponentViewSuccessfully() {
        let tasksDataModePage = TasksDataModelPage(application: application)
        
            tasksDataModePage
                .tapOnCell()
    }

}
