//
//  RadarView.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import Foundation
import UIKit

/**
 设置value1~5五个值就好，1是指向上方那个，剩下的顺时针
 */
@IBDesignable
class RadarView: UIView{
    @IBInspectable var bgColor: UIColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9882352941, alpha: 1)
    @IBInspectable var bgColor2: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.968627451, alpha: 1)
    @IBInspectable var bgLineColor: UIColor = #colorLiteral(red: 0.7215686275, green: 0.6666666667, blue: 1, alpha: 1)
    @IBInspectable var bgDotColor: UIColor = #colorLiteral(red: 0.7215686275, green: 0.6666666667, blue: 1, alpha: 1)
    @IBInspectable var bgLineWidth: CGFloat = 1
    @IBInspectable var bgDotRadius: CGFloat = 2.5
    @IBInspectable var radarStartColor: UIColor = #colorLiteral(red: 0.8078431373, green: 0.3058823529, blue: 1, alpha: 1)
    @IBInspectable var radarEndColor: UIColor = #colorLiteral(red: 0.2588235294, green: 0.9098039216, blue: 1, alpha: 0.8)
    @IBInspectable var value1: Double = 85.0
    @IBInspectable var value2: Double = 90.0
    @IBInspectable var value3: Double = 60.0
    @IBInspectable var value4: Double = 80.0
    @IBInspectable var value5: Double = 70.0
    
    private var values: [Double]{
        get{
            return [value1, value2, value3, value4, value5]
        }
    }
    
    func updateValues(values: [Int]) {
        value1 = Double(values[0])
        value2 = Double(values[1])
        value3 = Double(values[2])
        value4 = Double(values[3])
        value5 = Double(values[4])
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        
        let cxt = UIGraphicsGetCurrentContext()
        
        let bgr = Double(min(rect.width, rect.height) / 2) //背景五边形半径
        drawPentagonBg(rect: rect, cxt: cxt!, radius: bgr, color: bgColor)
        drawPentagonBg(rect: rect, cxt: cxt!, radius: bgr * 0.8, color: bgColor2)
        
        let ctr = bgr * 0.65 //实际数据的五边形半径
        let backgroundPath = CGMutablePath.init()
        for i in 0...5{
            backgroundPath.move(to: getCenterIn(rect))
            backgroundPath.addLine(to: getPointIn(rect, num: i, value: ctr))
        }
        
        for i in 1...5{
            if i == 4{
                continue
            }
            let j = (Double(i) + 5) / 10.0
            backgroundPath.move(to: getPointIn(rect, num: 0, value: ctr * j))
            for i in 1...4 {
                backgroundPath.addLine(to: getPointIn(rect, num: i, value: ctr * j))
            }
            backgroundPath.closeSubpath()
        }
        backgroundPath.closeSubpath()
        cxt?.setStrokeColor(bgLineColor.cgColor)
        cxt?.setLineWidth(bgLineWidth)
        cxt?.addPath(backgroundPath)
        cxt?.strokePath()
        
        let backgroundDot = CGMutablePath.init()
        for i in 0...5{
            let center = getPointIn(rect, num: i, value: ctr)
            backgroundDot.move(to: center)
            let ovalR = bgDotRadius
            let ovalRect = CGRect.init(x: center.x - ovalR, y: center.y - ovalR, width: ovalR * 2, height: ovalR * 2)
            backgroundDot.addEllipse(in: ovalRect)
            backgroundDot.closeSubpath()
        }
        cxt?.setFillColor(bgDotColor.cgColor)
        cxt?.addPath(backgroundDot)
        cxt?.fillPath()
        
        let contentPath = CGMutablePath.init()
        for (i,value) in values.enumerated(){
            let r = ctr * value / 100.0
            if i == 0{
                contentPath.move(to: getPointIn(rect, num: i, value: r))
            } else{
                contentPath.addLine(to: getPointIn(rect, num: i, value: r))
            }
        }
        contentPath.closeSubpath()
        
        let colors = [radarStartColor.cgColor, radarEndColor.cgColor] as CFArray
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: colors,
                                       locations: [0.3, 0.7])
        
        cxt?.addPath(contentPath)
        cxt?.clip()
        cxt?.drawLinearGradient(gradient!,
                                start: CGPoint.init(x: 0, y: 0),
                                end: CGPoint.init(x: rect.width, y: rect.height),
                                options: [])
        
        cxt?.fillPath()
        cxt?.resetClip()
    }
    
    func drawPentagonBg(rect: CGRect, cxt: CGContext, radius: Double, color: UIColor) {
        let path = CGMutablePath.init()
        path.move(to: getPointIn(rect, num: 0, value: radius))
        for i in 1...4 {
            path.addLine(to: getPointIn(rect, num: i, value: radius))
        }
        path.closeSubpath()
        
        cxt.setFillColor(color.cgColor)
        cxt.addPath(path)
        cxt.fillPath()
    }
    
    func getCenterIn(_ rect: CGRect) -> CGPoint{
        return CGPoint.init(x: rect.width / 2, y: rect.height / 2)
    }
    
    func getPointIn(_ rect: CGRect, num: Int, value: Double) -> CGPoint{
        let d = 360.0 / 5 * Double(num)
        let x = value * sin(d * Double.pi / 180)
        let y = value * cos(d * Double.pi / 180)
        let point = CGPoint.init(x: x, y: -y)
        
        let cx = getCenterIn(rect).x
        let cy = getCenterIn(rect).y
        
        let centerTrans = CGAffineTransform.init(translationX: cx, y: cy)
        return point.applying(centerTrans)
    }
}
