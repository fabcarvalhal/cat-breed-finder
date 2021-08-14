//
//  BreedListViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

protocol BreedListViewControllerInterface: AnyObject {
    
    func changeState(to state: BreedListViewController.BreedListState)
}

final class BreedListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar! 
    
    enum BreedListState {
        
        case loading
        case done
        case empty
        case error(message: String)
    }
    
    lazy var presenter: BreedListPresenterInterface = {
        let presenter = BreedListPresenter()
        presenter.view = self
        return presenter
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadBreeds()
    }
}

extension BreedListViewController: BreedListViewControllerInterface {
    
    func changeState(to state: BreedListState) {
        switch state {
        case .done:
            hideLoading()
            tableView.reloadData()
        case .loading:
            displayLoading()
        case .empty:
            hideLoading()
            print("show empty state")
        case .error(let message):
            hideLoading()
            print(message)
        }
    }
}

extension BreedListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        presenter.searchBreed(by: String())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBreed(by: searchBar.text ?? String())
    }
}

extension BreedListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.breedOutput.count
    }
}

extension BreedListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
