//
//  ModuleBuilder.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 21.08.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createComponentModule(id: String, router: RouterProtocol) -> UIViewController
    func createTabBar() -> UITabBarController
}

class ModuleBuilder: BuilderProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: BuilderProtocol?

    private func createMainViewControllerModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetWorkService()
        let navigationController = createNavigationViewController(controller: view, title: "Most Popular", image: UIImage(systemName: "house.fill"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return navigationController
    }
    
    private func createSearchControllerModule() -> UIViewController {
        let view = SearchViewController()
        let networkService = NetWorkService()
        let navigationController = createNavigationViewController(controller: view, title: "Search", image: UIImage(systemName: "magnifyingglass"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = SearchPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return navigationController
    }
    
    private func createFavoriteControllerModule() -> UIViewController {
        let view = FavoriteViewController()
        let networkService = NetWorkService()
        let dataStoreManager = CoreDataManager()
        let navigationController = createNavigationViewController(controller: view, title: "Favorite", image: UIImage(systemName: "suit.heart.fill"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = FavoriteViewPresenter(view: view, router: router, networkService: networkService, dataStoreManager: dataStoreManager)
        view.presenter = presenter
        return view
    }
    
    func createComponentModule(id: String, router: RouterProtocol) -> UIViewController {
        let view = ComponentViewController()
        let networkService = NetWorkService()
        let dataStoreManager = CoreDataManager()
        let presenter = ComponentPresenter(view: view, networkService: networkService, router: router, id: id, dataStoreManager: dataStoreManager)
        view.presenter = presenter
        return view
    }

    private func createNavigationViewController(controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title
        controller.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        navigationController.navigationBar.barTintColor = .lightBlack
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }
}

extension ModuleBuilder {
    
    func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let mainViewController = createMainViewControllerModule()
        let searchViewController = createSearchControllerModule()
        let favoriteViewController = createFavoriteControllerModule()
        
        tabBarController.viewControllers = [mainViewController, searchViewController, favoriteViewController]
        tabBarController.tabBar.tintColor = .systemYellow
        tabBarController.tabBar.barTintColor = .lightBlack
        return tabBarController
    }
}
