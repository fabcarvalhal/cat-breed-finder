//
//  BarView.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 15/08/21.
//

import UIKit

final class BarView: UIView {
    
    @IBInspectable
    var barColor: UIColor = UIColor.systemBlue
    
    enum FillMode: Float {
        
        case one = 0.2
        case two = 0.4
        case three = 0.6
        case four = 0.8
        case five = 1
    }
    
    private var fillableBarView = UIView()
    private var fillableBarViewWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        fillableBarView.backgroundColor = barColor
        fillableBarView.layer.cornerRadius = 4
        addSubview(fillableBarView)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        fillableBarView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            fillableBarView.widthAnchor.constraint(equalToConstant: .zero),
            fillableBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fillableBarView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            fillableBarView.topAnchor.constraint(equalTo: topAnchor),
            fillableBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        fillableBarViewWidthConstraint = constraints.first
        constraints.forEach { $0.isActive = true }
    }
    
    func set(fillMode: FillMode) {
        UIView.animate(withDuration: 0.4) {
            self.fillableBarViewWidthConstraint?.constant = self.bounds.width * CGFloat(fillMode.rawValue)
            self.layoutIfNeeded()
        }
    }
}
