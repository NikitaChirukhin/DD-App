//
//  SceneDelegate.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 20.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let assemblyBuilder = ModuleBuilder()
        window?.rootViewController = assemblyBuilder.createTabBar()
        window?.makeKeyAndVisible()
    }
}

