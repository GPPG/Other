//
//  RoundCornerButton.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import UIKit

@IBDesignable
class RoundCornerButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
