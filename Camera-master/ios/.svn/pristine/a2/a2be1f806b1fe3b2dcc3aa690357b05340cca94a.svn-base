//
//  PoseTabButton.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/6/4.
//

import Foundation
import UIKit

@IBDesignable
class PoseTabButton: UIButton{
    @IBInspectable var inSelected: Bool = false
    @IBInspectable var verticalSpaceOfUnderline: CGFloat = 2.5
    @IBInspectable var underLineWidth: CGFloat = 11.5
    @IBInspectable var underLineHeight: CGFloat = 2.5

    override func draw(_ rect: CGRect) {
        if inSelected{
            let newY = titleLabel!.frame.origin.y + titleLabel!.frame.height + verticalSpaceOfUnderline
            let newX = (titleLabel!.frame.width - underLineWidth) / 2
            let newRect = CGRect.init(x: newX, y: newY, width: underLineWidth, height: underLineHeight)
            let path = UIBezierPath.init(roundedRect: newRect, cornerRadius: 1.3)
            UIColor.black.setFill()
            path.fill()
        }
    }

    override func layoutSubviews() {
        if inSelected{
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
            titleLabel?.font = UIFont.init(name: "Futura-Bold", size: titleLabel!.font.pointSize)
            titleLabel?.sizeToFit()
            sizeToFit()
        } else{
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            titleLabel?.font = UIFont.init(name: "Futura-Medium", size: titleLabel!.font.pointSize)
            titleLabel?.sizeToFit()
            sizeToFit()
        }
        setNeedsDisplay()
        super.layoutSubviews()

    }
}
