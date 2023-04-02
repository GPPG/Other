//
//  UIImage+FixOrientation.swift
//  FACE
//
//  Created by HuangMingxi on 2019/2/28.
//  Copyright © 2019年 PJ. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // 修复图片旋转
    func fixOrientation(rear: Bool = false) -> UIImage {
        if self.imageOrientation == .up {
            return self
        }

        var orientation = self.imageOrientation
        var transform = CGAffineTransform.identity

        switch orientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break

        default:
            break
        }

        switch orientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break

        default:
            break
        }

        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)

        switch orientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break

        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }

        let cgimg: CGImage = (ctx?.makeImage())!
        var img: UIImage
        if rear{
            img = UIImage.init(cgImage: cgimg, scale: 1, orientation: .upMirrored)
        } else{
            img = UIImage.init(cgImage: cgimg)
        }
        UIGraphicsEndImageContext()

        return img
    }
}
