//
//  RouterProtocol.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 03.09.2021.
//

import UIKit

protocol RouterProtocol {
    func showComponent(id: String)
    func pop()
    var navigationController: UINavigationController { get set }
}

class Router: RouterProtocol {

    var navigationController: UINavigationController
    var assemblyBuilder: BuilderProtocol?

    func showComponent(id: String) {
        guard let componentViewController = assemblyBuilder?.createComponentModule(id: id, router: self) else { return }
        navigationController.pushViewController(componentViewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
}
