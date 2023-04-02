//
//  RoundGPUImageView.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/6.
//

import UIKit
import GPUImage

class RoundGPUImageView: GPUImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
    
}
