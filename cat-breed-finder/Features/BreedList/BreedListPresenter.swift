//
//  BreedListPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

protocol BreedListPresenterInterface: AnyObject {
    
    var breedOutput: [CatBreed] { get }
    
    func loadBreeds()
    func loadMore()
    func searchBreed(by name: String)
}

final class BreedListPresenter: BreedListPresenterInterface {
    
    private let theCatApiClient = TheCatApiClient()
    
    weak var view: BreedListViewControllerInterface?
    private var breedQuery: String = String()
    private let breedListLimit = 10
    private var currentPage = Int.zero
    private var hasMorePages = true
    private var isLoading = false
    
    var breedOutput: [CatBreed] {
        if !breedQuery.isEmpty {
            return breedList.filter { $0.name.contains(self.breedQuery) }
        }
        return breedList
    }
    
    private var breedList = [CatBreed]()
    
    func loadBreeds() {
        guard !isLoading else  { return }
        breedQuery = ""
        isLoading = true
        view?.changeState(to: .loading)
        let request = CatBreedListRequest(page: currentPage, limit: breedListLimit)
        theCatApiClient.getBreeds(request: request) { [weak self] result in
            self?.isLoading = false
            self?.runOnMainTread {
                switch result {
                case .success(let response):
                    self?.hasMorePages = response.count == self?.breedListLimit
                    self?.breedList = response
                    guard !response.isEmpty else {
                        self?.view?.changeState(to: .done)
                        return
                    }
                    self?.view?.changeState(to: .done)
                case .failure(let error):
                    self?.view?.changeState(to: .error(message: error.localizedDescription))
                }
            }
        }
    }
    
    func loadMore() {
        guard !isLoading && breedQuery.isEmpty && hasMorePages else  { return }
        isLoading = true
        let request = CatBreedListRequest(page: currentPage + 1, limit: breedListLimit)
        theCatApiClient.getBreeds(request: request) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            self.runOnMainTread {
                switch result {
                case .success(let response):
                    self.hasMorePages = response.count == self.breedListLimit
                    self.currentPage += 1
                    self.breedList += response
                    self.view?.changeState(to: .done)
                case .failure(let error):
                    self.view?.changeState(to: .error(message: error.localizedDescription))
                }
            }
        }
    }
    
    func searchBreed(by name: String) {
        breedQuery = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !breedOutput.isEmpty else {
            view?.changeState(to: .empty)
            return
        }
        view?.changeState(to: .done)
    }
    
    private func runOnMainTread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async {
                work()
            }
        }
    }
}
