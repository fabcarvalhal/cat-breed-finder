//
//  BreedDetailsPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import Foundation

protocol BreedDetailsPresenterInterface: AnyObject {
    
    var breed: CatBreed? { get set }
    var isFavourite: Bool { get }
    
    func toggleFavourite()
}

final class BreedDetailsPresenter: BreedDetailsPresenterInterface {
    
    private let realmManager: RealmManagerInterface
    
    weak var view: BreedDetailsViewControllerInterface?
    
    var breed: CatBreed?
    
    var isFavourite: Bool {
        guard let breed = breed else { return false }
        return (try? realmManager.getObject(by: breed.id, of: RealmCatBreed.self)) != nil
    }
    
    init(realmManager: RealmManagerInterface = RealmManager()) {
        self.realmManager = realmManager
    }
    
    func toggleFavourite() {
        guard let breed = breed else { return }
        do {
            if isFavourite {
                try realmManager.delete(objectWith: breed.id, of: RealmCatBreed.self)
            } else {
                try realmManager.save(RealmCatBreed(from: breed))
            }
            view?.configureFavouriteButton()
        } catch {
            view?.displayError(message: error.localizedDescription)
        }
    }
}
