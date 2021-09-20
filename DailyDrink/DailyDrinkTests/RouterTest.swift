//
//  RouterTest.swift
//  DailyDrinkTests
//
//  Created by Никита Чирухин on 20.09.2021.
//

import XCTest
@testable import DailyDrink

class RouterProtocolTest: XCTestCase {
    
    var router: RouterProtocol!
    var builder: MockModuleBuilder!
    
    override func setUp() {
        let navigationController = UINavigationController()
        builder = MockModuleBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: builder)
    }
    
    override class func tearDown() {
        
    }
}

