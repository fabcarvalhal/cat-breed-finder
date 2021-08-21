//
//  TutorialCell.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import UIKit

final class TutorialCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageImageView: UIImageView!
    
    static let identifier = String(describing: TutorialCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageImageView.image = nil
    }
    
    func set(viewModel: TutorialCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        pageImageView.image = viewModel.image
    }
}
