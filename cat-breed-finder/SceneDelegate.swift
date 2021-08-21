//
//  SceneDelegate.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 07/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let userDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        start()
    }
    
    func start() {
        let seenTutorial: Bool? = userDefaultsManager.getValue(for: .seenTutorial)
        if seenTutorial == true {
            showMainTabViewController()
        } else {
            showTutorial()
        }
    }
    
    private func showMainTabViewController() {
        let mainTab = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "MainTabBar")
            changeRootViewController(to: mainTab)
    }
    
    private func showTutorial() {
        let tutorialVC = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "TutorialViewController")
            changeRootViewController(to: tutorialVC)
    }
    
    private func changeRootViewController(to viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

