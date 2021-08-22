//
//  BreedDetailsViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 15/08/21.
//

import UIKit
import SDWebImage

protocol BreedDetailsViewControllerInterface: AnyObject {
    
    func displayError(message: String)
    func configureFavouriteButton()
}

final class BreedDetailsViewController: UIViewController {
    
    @IBOutlet private weak var catImageView: UIImageView! {
        didSet {
            catImageView.sd_imageTransition = .fade
        }
    }
    
    @IBOutlet private weak var breedNameLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var breedDescriptionLabel: UILabel!
    @IBOutlet private weak var breedWeightLabel: UILabel!
    @IBOutlet private weak var lifeSpanLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var characteristicsLabel: UILabel!
    @IBOutlet private weak var adaptabilityLevelBarView: BarView!
    @IBOutlet private weak var affectionLevelBarView: BarView!
    @IBOutlet private weak var dogFriendlyLevelBarView: BarView!
    @IBOutlet private weak var energyLevelBarView: BarView!
    @IBOutlet private weak var intelligenceLevelBarView: BarView!
    @IBOutlet private weak var sheddingLevelBarView: BarView!
    @IBOutlet private weak var socialNeedsLevelBarView: BarView!
    @IBOutlet private weak var childFriendlyLevelBarView: BarView!
    @IBOutlet private weak var healthIssuesLevelBarView: BarView!
    @IBOutlet private weak var strangerFriendlyLevelBarView: BarView!
    @IBOutlet private weak var groomingLevelBarView: BarView!
    
    @IBOutlet private weak var characteristicsStackView: UIStackView! {
        didSet {
            characteristicsStackView.setCustomSpacing(24, after: characteristicsLabel)
        }
    }
    
    lazy var presenter: BreedDetailsPresenterInterface = {
        let presenter = BreedDetailsPresenter()
        presenter.view = self
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBreedMainInfo()
        configureFavouriteButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayCharacteristicBarInfos()
    }
    
    private func displayBreedMainInfo() {
        catImageView.sd_setImage(with: URL(string: presenter.breed?.image?.url ?? ""),
                                 placeholderImage: UIImage(named: "placeholder"),
                                 options: [.scaleDownLargeImages, .progressiveLoad])
        breedDescriptionLabel.text = presenter.breed?.description
        breedNameLabel.text = presenter.breed?.name
        if let weight = presenter.breed?.weight.imperial {
            breedWeightLabel.text = String(format: "%@ inches", weight)
        }
        lifeSpanLabel.text = String(format: "Life span: %@ years", presenter.breed?.lifeSpan ?? "N/A")
        originLabel.text = String(format: "Origin: %@", presenter.breed?.origin ?? "N/A")
    }
    
    private func displayCharacteristicBarInfos() {
        guard let breed = presenter.breed else { return }
        adaptabilityLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.adaptability))
        
        affectionLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.affectionLevel))
        
        dogFriendlyLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.dogFriendly))
        
        energyLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.energyLevel))
        
        intelligenceLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.intelligence))
        
        sheddingLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.sheddingLevel))
        
        socialNeedsLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.socialNeeds))
        
        childFriendlyLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.childFriendly))
        
        groomingLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.grooming))
        
        healthIssuesLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.healthIssues))
        
        strangerFriendlyLevelBarView
            .set(fillMode: BarView.FillMode(rawValue: breed.strangerFriendly))
    }
    
    @IBAction func tapFavouriteButtonAction() {
        presenter.toggleFavourite()
    }
}

extension BreedDetailsViewController: BreedDetailsViewControllerInterface {
    
    func displayError(message: String) {
        showErrorAlert(message: message, title: "Error")
    }
    
    func configureFavouriteButton() {
        let imageName = presenter.isFavourite ? "star.fill" : "star"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
