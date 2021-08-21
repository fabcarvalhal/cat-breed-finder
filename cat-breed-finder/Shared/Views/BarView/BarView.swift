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
    
    enum FillMode: Int {
        
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        
        var barPercentage: CGFloat {
            switch self {
            case .one:
                return 0.2
            case .two:
                return 0.4
            case .three:
                return 0.6
            case .four:
                return 0.8
            case .five:
                return 1
            }
        }
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
    
    func set(fillMode: FillMode?) {
        guard let mode = fillMode else { return }
        UIView.animate(withDuration: 0.4) {
            self.fillableBarViewWidthConstraint?.constant = self.bounds.width * mode.barPercentage
            self.layoutIfNeeded()
        }
    }
}
