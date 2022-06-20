//
//  CustomView.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    @IBInspectable var roundedCornersValue : CGFloat = 0.0 {
        didSet {
            setupLayout()
        }
    }
    @IBInspectable var borderWidthValue : CGFloat = 0.0 {
        didSet{
            setupLayout()
        }
    }
    @IBInspectable var borderColor : UIColor = .gray
    {
        didSet{
            setupLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    func roundAllCorners(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setupLayout() {
        self.roundAllCorners(radius: roundedCornersValue)
        self.layer.borderWidth = borderWidthValue
        self.layer.borderColor = borderColor.cgColor
    }
    
    // USE FOR GRADIENT COLOR FOR THE VIEW.
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
    
    
    func addBubleAnimation(circleColor :UIColor = .black, duration :Double = 0.5) {
        let circle = UIView()
        
        let startingPoint = CGPoint(x: self.bounds.size.width, y: 0)
        circle.frame = frameForCircle(startPoint: startingPoint)
        
        circle.layer.cornerRadius = circle.frame.size.height / 2
        circle.center = startingPoint
        circle.backgroundColor = circleColor
        circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.addSubview(circle)
        self.bringSubviewToFront(circle)
//        self.sendSubviewToBack(circle)
        
        UIView.animate(withDuration: duration, animations: {
            
            circle.transform = CGAffineTransform.identity
            
        }, completion: { (success:Bool) in
            if success {
                self.backgroundColor = circleColor
                circle.removeFromSuperview()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                }
            }
        })
    }
    
    private func frameForCircle (startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, self.bounds.size.width - startPoint.x)
        let yLength = fmax(startPoint.y, self.bounds.size.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    
}
