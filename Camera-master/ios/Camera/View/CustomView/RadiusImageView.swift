//
//  RadiusImageView.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/6/4.
//

import Foundation
import UIKit

@IBDesignable
class RadiusImageView: UIImageView {

    @IBInspectable var radius: CGFloat = 7

    override func layoutSubviews() {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
