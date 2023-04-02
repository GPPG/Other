//
//  VerticalGradientView.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import UIKit

@IBDesignable
class VerticalGradientView: UIView {
    
    @IBInspectable var startColor: UIColor? = UIColor.white
    @IBInspectable var endColor: UIColor? = UIColor.white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
}
