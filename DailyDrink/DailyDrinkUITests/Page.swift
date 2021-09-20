//
//  Page.swift
//  DailyDrinkUITests
//
//  Created by Никита Чирухин on 20.09.2021.
//

import XCTest

protocol Page {
    var application: XCUIApplication { get }
    
    init(application: XCUIApplication)
}
