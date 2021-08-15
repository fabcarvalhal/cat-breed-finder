//
//  CenterButtonTabBar.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

final class CenterButtonTabBar: UITabBar {
    
    var centerButtonActionHandler: (() -> Void)?
    
    lazy var centerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = button.frame.size.width / 2.0
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
        return button
    }()
    
    @IBInspectable
    var centerButtonColor: UIColor?
    
    @IBInspectable
    var centerButtonHeight: CGFloat = 50
    
    @IBInspectable
    var padding: CGFloat = 4
    
    @IBInspectable
    var buttonImage: UIImage?
    
    @IBInspectable
    var buttonTitle: String?
    
    @IBInspectable
    var tabbarColor: UIColor = UIColor.lightGray
    
    @IBInspectable
    var unselectedItemColor: UIColor = UIColor.white
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        addShape()
        setupCenterButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = tabbarColor.cgColor
        shapeLayer.lineWidth = 0
        
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
        tintColor = centerButtonColor
        unselectedItemTintColor = unselectedItemColor
    }
    
    private func createPath() -> CGPath {
        let height: CGFloat = 80 + padding
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: .zero)
        
        path.addLine(to: CGPoint(x: (centerWidth - height), y: 0))
        path.addCurve(to: CGPoint(x: centerWidth, y: height - 40),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: height - 40))
        
        path.addCurve(to: CGPoint(x: (centerWidth + height ), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height - 40),
                      controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: .zero))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: .zero, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    private func setupCenterButton() {
        centerButton.frame = CGRect(x: (self.bounds.width / 2)-(centerButtonHeight/2),
                                    y: -10,
                                    width: centerButtonHeight,
                                    height: centerButtonHeight)
        addSubview(centerButton)
    }
    
    @objc func centerButtonAction(sender: UIButton) {
        centerButtonActionHandler?()
    }
}
