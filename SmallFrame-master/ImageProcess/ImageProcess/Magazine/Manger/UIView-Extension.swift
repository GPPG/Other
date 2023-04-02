//
//  UIView-Extension.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/11.
//

import UIKit

extension UIView {

    //将当前视图转为UIImage
    func screenshotAsImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func screenshotAsImage(_ rect: CGRect) -> UIImage {
        
        var image = UIImage.init()
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.croptoRect(rect)
    }

}
