//
//  CatBreedCell.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

final class CatBreedCell: UITableViewCell {
    
    static let identifier = String(describing: CatBreedCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        catImageView.layer.cornerRadius = 40
    }
}
