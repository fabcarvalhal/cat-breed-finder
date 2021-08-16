//
//  CatBreedCell.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit
import SDWebImage

final class CatBreedCell: UITableViewCell {
    
    static let identifier = String(describing: CatBreedCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var catImageView: UIImageView! {
        didSet {
            catImageView.sd_imageTransition = .fade
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        catImageView.layer.cornerRadius = 40
    }
    
    func set(viewModel: CatBreedCellViewModel) {
        catImageView.sd_setImage(with: viewModel.photoUrl,
                                 placeholderImage: UIImage(named: "placeholder"),
                                 options: [.scaleDownLargeImages, .progressiveLoad])
        titleLabel.text = viewModel.breedName
    }
}
