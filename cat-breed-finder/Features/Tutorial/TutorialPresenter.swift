//
//  TutorialPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation
import UIKit

protocol TutorialPresenterInterface: AnyObject {
    
    var stepsViewModels: [TutorialCellViewModel] { get }
    var righButtonTitle: String { get }
    var isLeftButtonVisible: Bool { get }
    
    func rightButtonAction()
    func leftButtonAction()
}

final class TutorialPresenter: TutorialPresenterInterface {
    
    private var currentPage = 0
    
    weak var view: TutorialViewControllerInterface?
    
    private let userDefaultsManager: UserDefaultsManagerInterface
    
    init(userDefaultsManager: UserDefaultsManagerInterface = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func rightButtonAction() {
        if currentPage == stepsViewModels.count - 1 {
            userDefaultsManager.save(true, for: .seenTutorial)
            view?.finish()
        } else {
            currentPage += 1
            view?.stepTo(index: currentPage)
            view?.configureViewElements()
        }
    }
    
    func leftButtonAction() {
        guard currentPage != 0 else { return }
        currentPage -= 1
        view?.stepTo(index: currentPage)
        if currentPage == 0 {
            view?.configureViewElements()
        }
    }
    
    var stepsViewModels: [TutorialCellViewModel] {
        [
            TutorialCellViewModel(image: nil,
                                  title: "Welcome to Cat Breed Finder!",
                                  description: "Here you can find some cat breeds and more! Tap Next to know more :)"),
            TutorialCellViewModel(image: UIImage(named: "breedsScreenTutorial"),
                                  title: "List and filter",
                                  description: "Find Cat breeds on our home screen and filter the results by typing on the search bar if you want"),
            TutorialCellViewModel(image: UIImage(named: "detailsScreenTutorial"),
                                  title: "See the details",
                                  description: "Find a lot of information about the selected breed on the details screen and even save one as your favorite by tapping the star icon if you want."),
            TutorialCellViewModel(image: UIImage(named: "favoritesScreenTutorial"),
                                  title: "See your favorites",
                                  description: "See the favorites you saved without having to load from internet"),
            TutorialCellViewModel(image: UIImage(named: "breedFinderScreen"),
                                  title: "Breed Finder!",
                                  description: "Select a photo of your cat from camera roll, camera or photo library and Cat Breed Finder will guess wich breed your cat is as fast as you can imagine!"),
            
        ]
    }
    
    var righButtonTitle: String {
        currentPage < stepsViewModels.count - 1 ? "Next" : "Finish"
    }
    
    var isLeftButtonVisible: Bool {
        currentPage > 0
    }
}
