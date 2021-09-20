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

    func test_ShowComponent() {
        
        //arrange
        let navVC = UINavigationController()
        builder = MockModuleBuilder()
        router = Router(navigationController: navVC, assemblyBuilder: builder)
        let expectation = "success"
        
        //act
        router.showComponent(id: expectation)
    
        // assert
        XCTAssertTrue(builder.workingTest)
    }
}

