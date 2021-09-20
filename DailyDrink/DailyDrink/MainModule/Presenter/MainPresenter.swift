//
//  MainPresenter.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 21.08.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getDrinks()
    func tapOnTheDrink(id: String)
    func makeImage(img: Data?) -> UIImage
    var drinks: [Drink] { get set }
}

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var drinks: [Drink] = []
    var router: RouterProtocol
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getDrinks()
    }
    
    func tapOnTheDrink(id: String) {
        router.showComponent(id: id)
    }
    
    func makeImage(img: Data?) -> UIImage {
        guard let data = img else {
            return UIImage(systemName: "trash")!
        }
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "trash")!
    }
    
    func getDrinks() {
        networkService.getTenTopDrinks { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.drinks = response.drinks
                    self.getTheImageDrink()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getTheImageDrink(_ completion: (() -> Void )? = nil) {
        let dispatchGroup = DispatchGroup()
        for (index, drink) in drinks.enumerated() {
            dispatchGroup.enter()
            networkService.getSmallDrinkImage(url: drink.imageId, completion: { [weak self] result in
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
            completion?()
        }
    }
}
