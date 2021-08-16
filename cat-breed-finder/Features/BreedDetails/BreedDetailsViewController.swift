//
//  BreedDetailsViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 15/08/21.
//

import UIKit

final class BreedDetailsViewController: UIViewController {
    
    @IBOutlet private weak var catImageView: UIImageView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
