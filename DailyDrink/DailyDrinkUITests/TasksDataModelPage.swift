//
//  TasksDataModelPage.swift
//  DailyDrinkUITests
//
//  Created by Никита Чирухин on 20.09.2021.
//

import XCTest

class TasksDataModelPage: Page {
    var application: XCUIApplication
    
    private var descriptionButton: XCUIElement { return application.staticTexts["Long Island Tea"] }
    
    required init(application: XCUIApplication) {
        self.application = application
    }
    
    func tapOnCell() {
        descriptionButton.tap()
    }
}
