//
//  BreedListViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit
import SDWebImage

protocol BreedListViewControllerInterface: AnyObject {
    
    func changeState(to state: BreedListViewController.BreedListState)
}

final class BreedListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CatBreedCell", bundle: Bundle.main),
                               forCellReuseIdentifier: CatBreedCell.identifier)
            tableView.estimatedRowHeight = 120
        }
    }
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.delegate = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search by breed name"
        return controller
    }()
    
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
        navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
            tableView.reloadData()
        case .error(let message):
            hideLoading()
            showErrorAlert(message: message, title: "Error")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetMaxY: Float = Float(scrollView.contentOffset.y + scrollView.bounds.size.height)
        let contentHeight: Float = Float(scrollView.contentSize.height)
        let lastCellIsVisible = contentOffsetMaxY > contentHeight - 100
        if lastCellIsVisible {
            presenter.loadMore()
        }
    }
}

extension BreedListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatBreedCell.identifier, for: indexPath)
        guard let breedCell = cell as? CatBreedCell else { return cell }
        let item = presenter.breedOutput[indexPath.row]
        let imageUrl = item.image?.url ?? ""
        breedCell
            .catImageView
            .sd_setImage(with: URL(string: imageUrl),
                         placeholderImage: UIImage(named: "placeholder"))
        breedCell.titleLabel.text = item.name
        return breedCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.breedOutput.count
    }
}

extension BreedListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BreedListViewController: UISearchResultsUpdating, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchBreed(by: searchController.searchBar.text ?? String())
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        presenter.searchBreed(by: String())
    }
}
