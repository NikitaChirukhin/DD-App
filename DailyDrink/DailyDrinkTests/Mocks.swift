//
//  Mocks.swift
//  DailyCoctailTests
//
//  Created by Никита Чирухин on 19.09.2021.
//

import UIKit
@testable import DailyDrink

class MockMainView: MainViewProtocol {
    
    var successCounter: Int = 0
    
    func success() {
        successCounter += 1
    }
    
    func failure(error: Error) { }
}

class MockModuleBuilder: BuilderProtocol {
    
    var workingTest = false
    
    func createComponentModule(id: String, router: RouterProtocol) -> UIViewController {
        let vc = UIViewController()
        workingTest = true
        return vc
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        return tabBar
    }
}

class MockNetworkService: NetworkServiceProtocol {
    
    var drinks: Drinks?
    
    init() { }
    
    convenience init(drinks: Drinks?) {
        self.init()
        self.drinks = drinks
    }
    
    func getTenTopDrinks(completion: @escaping (Result<Drinks, Error>) -> Void) {
        if let drinks = drinks {
            completion(.success(drinks))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getSmallDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if url == "success" {
            completion(.success(Data()))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getDrinkComponent(url: String, completion: @escaping (Result<DrinkComponentsAPI, Error>) -> Void) { }
    func getBigDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) { }
    func requestByName(url: String, completion: @escaping (Result<Drinks, Error>) -> Void) { }
}

class MockRouter: RouterProtocol {
    
    func showComponent(id: String) { }
    func pop() { }

    var navigationController: UINavigationController
    var builder: BuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.builder = assemblyBuilder
        self.navigationController = navigationController
    }
}
