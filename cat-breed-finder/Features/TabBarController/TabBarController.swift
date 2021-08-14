//
//  TabBarController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Constants
    private let catFinderSegueIdentifier = "CatFinderSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCenterButton()
    }
    
    private func configureCenterButton() {
        guard let tabBar = tabBar as? CenterButtonTabBar else { return }
        tabBar.centerButtonActionHandler = { [weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.catFinderSegueIdentifier, sender: nil)
        }
    }
}
