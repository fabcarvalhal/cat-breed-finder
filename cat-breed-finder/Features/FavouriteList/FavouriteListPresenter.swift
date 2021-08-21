//
//  FavouriteListPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import Foundation
import RealmSwift
import UIKit

protocol FavouriteListPresenterInterface: AnyObject {
    
    var breedListViewModels: [CatBreedCellViewModel] { get }
    
    func fetchFavourites()
    func getCompleteBreedInfo(on index: Int) -> CatBreed?
    func deleteItem(at index: Int)
}

final class FavouriteListPresenter: FavouriteListPresenterInterface {
    
    private let realmManager: RealmManagerInterface
    private var notificationToken: NotificationToken?
    
    var breedListViewModels: [CatBreedCellViewModel] {
        guard let results = fetchedResults else  { return [] }
        return results
            .map { CatBreedCellViewModel(photoUrl: URL(string: $0.image?.url ?? ""), breedName: $0.name) }
    }
    private var fetchedResults: Results<RealmCatBreed>?
    
    weak var view: FavouriteListViewControllerInterface?
    
    init(realmManager: RealmManagerInterface = RealmManager()) {
        self.realmManager = realmManager
    }
    
    func deleteItem(at index: Int) {
        guard let fetchedResults = fetchedResults,
              fetchedResults.indices.contains(index)
        else { return }
        do {
            try realmManager.delete(objectWith: fetchedResults[index].id, of: RealmCatBreed.self)
        } catch let error {
            view?.displayError(message: error.localizedDescription)
        }
    }
    
    func fetchFavourites() {
        do {
            let results = try realmManager.list(objectType: RealmCatBreed.self)
            self.fetchedResults = results
            setupDataSourceNotification(on: results)
        } catch let error {
            view?.displayError(message: error.localizedDescription)
        }
    }
    
    func setupDataSourceNotification(on items: Results<RealmCatBreed>) {
        notificationToken = items.observe { [weak self] change in
            switch change {
            case .initial:
                self?.view?.displayItems()
            case .update(_, let deletions, let insertions, let modifications):
                self?.view?.updateFavourites(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                self?.view?.displayError(message: error.localizedDescription)
            }
        }
    }
    
    func getCompleteBreedInfo(on index: Int) -> CatBreed? {
        guard let results = fetchedResults,
              results.indices.contains(index) else { return nil }
        return CatBreed(from: results[index])
    }
}
