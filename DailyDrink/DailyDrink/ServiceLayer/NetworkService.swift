//
//  NetworkService.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 26.08.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    func getTenTopDrinks(completion: @escaping (Result<Drinks, Error>) -> Void)
    func getSmallDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func getDrinkComponent(url: String, completion: @escaping (Result<DrinkComponentsAPI, Error>) -> Void)
    func getBigDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func requestByName(url: String, completion: @escaping (Result<Drinks, Error>) -> Void)
}

class NetWorkService: NetworkServiceProtocol {
    
    private func genericFetch<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(CustomError.serverError))
                return
            }
            
            do {
                guard let data = data else { return }
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(obj))
            } catch  (let error) {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func getDrinkComponent(url: String, completion: @escaping (Result<DrinkComponentsAPI, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(url)"
        genericFetch(url: urlString, completion: completion)
    }
    
    func getTenTopDrinks(completion: @escaping (Result<Drinks, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
        genericFetch(url: urlString, completion: completion)
    }
    
    func searchForDrinks(url: String, completion: @escaping (Result<Drinks, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
        genericFetch(url: urlString, completion: completion)
    }
    
    func requestByName(url: String, completion: @escaping (Result<Drinks, Error>) -> Void) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(url)"
        genericFetch(url: urlString, completion: completion)
    }
}

//MARK: NetworkService for images

extension NetWorkService {
    //TODO: Custom Error
    private func fetchImages(url: String, completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                completion(.success(data))
                return
            }
            return
        }
        .resume()
    }
    
    func getSmallDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString =  "\(url)/preview"
        fetchImages(url: urlString, completion: completion)
    }
    
    func getBigDrinkImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        fetchImages(url: url, completion: completion)
    }
}
