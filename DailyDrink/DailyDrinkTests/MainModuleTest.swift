//
//  MainPresenterTest.swift
//  DailyCoctailTests
//
//  Created by Никита Чирухин on 21.08.2021.
//

import XCTest
@testable import DailyDrink

class MainPresenterTest: XCTestCase {
    
    var view: MockMainView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var drinks: [Drink] = []
    
    override func setUp() {
        let navigationController = UINavigationController()
        let builder = MockModuleBuilder()
        
        router = MockRouter(navigationController: navigationController, assemblyBuilder: builder)
    }

    override func tearDown() {
        view = nil
        presenter = nil
        networkService = nil
        router = nil
    }
    
    func test_GetViewSucces() {
        
        //arrange

        let drink = Drink(name: "Foo", id: "Bar", imageId: "Baz", image: nil)
        let drinks = Drinks(drinks: [drink])
        view = MockMainView()
        networkService = MockNetworkService(drinks: drinks)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        let expectation = XCTestExpectation(description: "image")
        // act
        
        presenter.getTheImageDrink {
            expectation.fulfill()
        }
        
        // assert
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(view.successCounter, 1)
    }
    
    func test_GetTheImageDrinkSuccess() {
        
        //arrange
        let expectation = XCTestExpectation()
        let drink = Drink(name: "Foo", id: "Bar", imageId: "success", image: Data())
        let drinks = Drinks(drinks: [drink])
        view = MockMainView()
        networkService = MockNetworkService(drinks: drinks)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        presenter.drinks.append(drink)

        // act
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        presenter.getTheImageDrink()

        // assert

        XCTAssertEqual(view.successCounter, 0)
    }

    func test_GetDrinksFail() {
        let expectation = XCTestExpectation()
 
        view = MockMainView()
        networkService = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
        
        networkService.getTenTopDrinks { result in
            switch result {
            case .success(let drink):
                print(drink)
            case .failure(let error):
                catchError = error
            }
        
        }
        XCTAssertNotNil(catchError)
    }
}
