//
//  RoundImageView.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {
    
    @IBInspectable var borderWidth: Int = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
}
