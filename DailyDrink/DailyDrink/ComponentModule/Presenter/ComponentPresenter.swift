//
//  ComponentPresenter.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 27.08.2021.
//

import UIKit


protocol ComponentViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}


protocol ComponentViewPresenterProtocol: AnyObject {
    init(view: ComponentViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, id: String, dataStoreManager: CoreDataManagerProtocol)
    func popToRootViewController()
    func saveDrinkToCoreData()
    var drinkComponent: DrinkComponent? { get set }
}


class ComponentPresenter: ComponentViewPresenterProtocol {

    weak var view: ComponentViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var drinkComponentAPI: DrinkComponentAPI?
    var dataStoreManager: CoreDataManagerProtocol
    var drinkComponent: DrinkComponent?
    var id: String
    
    required init(view: ComponentViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, id: String, dataStoreManager: CoreDataManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.id = id
        self.dataStoreManager = dataStoreManager
        getComponent()
    }
}


extension ComponentPresenter {
    
    private func getComponent() {
        networkService.getDrinkComponent(url: id, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let drink):
                    guard let drink = drink.drinks.first else { return }
                    self.drinkComponent = DrinkComponent(drinkComponent: drink)
                    self.getImage(url: drink.imageUrl)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    private func getImage(url: String) {
        networkService.getSmallDrinkImage(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    self.makeImage(imageData: imageData)
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    private func makeImage(imageData: Data) {
        if let image = UIImage(data: imageData) {
            drinkComponent?.image = image
        }
    }
    
    func popToRootViewController() {
        router?.pop()
    }
    
    func saveDrinkToCoreData() {
        if let drink = drinkComponent {
            dataStoreManager.uploadDrink(drink: drink)
        }
    }
}
