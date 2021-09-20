//
//  SearchViewPresenter.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 17.09.2021.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    var drinks: [Drink] { get set }
    func searchDrinks(request: String?)
    func tapOnTheDrink(id: String)
    func makeImage(img: Data?) -> UIImage
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var drinks: [Drink] = []
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol
    
    
    required init(view: SearchViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    func searchDrinks(request: String?) {
        if let url = request {
            networkService.requestByName(url: url, completion: { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.drinks = response.drinks
                        self.getTheImageDrink()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            })
        }
    }
    
    func getTheImageDrink() {
        let dispatchGroup = DispatchGroup()
        for (index, drink) in drinks.enumerated() {
            dispatchGroup.enter()
                self.networkService.getSmallDrinkImage(url: drink.imageId, completion: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let tableImage):
                        self.drinks[index].image = tableImage
                        dispatchGroup.leave()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            })
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.success()
        }
    }
    
    func makeImage(img: Data?) -> UIImage {
        guard let data = img else {
            return UIImage(named: "drinkShimmer")!
        }
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage(named: "drinkShimmer")!
    }
    
    func tapOnTheDrink(id: String) {
        router.showComponent(id: id)
    }
}

