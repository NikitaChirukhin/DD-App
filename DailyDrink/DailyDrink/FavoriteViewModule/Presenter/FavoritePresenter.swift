//
//  FavoritePresenter.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 09.09.2021.
//

import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol FavoritePresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol, dataStoreManager: CoreDataManagerProtocol)
    var drinks: [Drink] { get set }
    func searchDrinks (request: String)
    func tapOnTheDrink(id: String)
}

class FavoriteViewPresenter: FavoritePresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var dataStoreManager: CoreDataManagerProtocol
    var drinkComponent: DrinkComponent?
    var drinks: [Drink] = []
    
    required init(view: FavoriteViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol, dataStoreManager: CoreDataManagerProtocol) {
        self.router = router
        self.networkService = networkService
        self.view = view
        self.router = router
        self.dataStoreManager = dataStoreManager
    }
    
    func countFavoriteDrink() -> Int {
        return dataStoreManager.getAllDrinksComponents().count
    }
    
    func searchDrinks(request: String) {
        
    }
    
    func tapOnTheDrink(id: String) {
        
    }
}
