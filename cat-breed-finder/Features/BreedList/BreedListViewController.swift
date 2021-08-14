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
    
    enum BreedListState {
        
        case loading
        case done
        case empty
        case error(message: String)
    }
    
    var presenter: BreedListPresenterInterface = BreedListPresenter()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadBreeds()
    }
}

extension BreedListViewController: BreedListViewControllerInterface {
    
    func changeState(to state: BreedListState) {
        
    }
}
