//
//  FavouriteListViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import UIKit

protocol FavouriteListViewControllerInterface: AnyObject {
    
    func displayItems()
    func updateFavourites(deletions: [Int], insertions: [Int], modifications: [Int])
}

final class FavouriteListViewController: UITableViewController {
    
    private lazy var presenter: FavouriteListPresenterInterface = {
        let presenter = FavouriteListPresenter()
        presenter.view = self
        return presenter
    }()
    
    private let breedDetailSegueIdentifier = "showBreedDetailsSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CatBreedCell", bundle: Bundle.main),
                           forCellReuseIdentifier: CatBreedCell.identifier)
        tableView.estimatedRowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavourites()
    }
}

extension FavouriteListViewController: FavouriteListViewControllerInterface {
    
    func displayItems() {
        tableView.reloadData()
    }
    
    func updateFavourites(deletions: [Int], insertions: [Int], modifications: [Int]) {
        tableView.performBatchUpdates({
            tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: .zero) }),
                                 with: .fade)
            tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: .zero) }),
                                 with: .fade)
            tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: .zero) }),
                                 with: .fade)
        })
    }
}


extension FavouriteListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.breedListViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatBreedCell.identifier, for: indexPath)
        guard let breedCell = cell as? CatBreedCell else { return cell }
        breedCell.set(viewModel: presenter.breedListViewModels[indexPath.row])
        return breedCell
    }
}

extension FavouriteListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: breedDetailSegueIdentifier,
                     sender: presenter.getCompleteBreedInfo(on: indexPath.row))
    }
}
