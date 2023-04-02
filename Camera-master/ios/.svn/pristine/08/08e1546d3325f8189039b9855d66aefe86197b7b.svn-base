//
//  BrightnessAdjustment.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/22.
//

import Foundation

/** 亮度调整 */
class BrightnessAdjustment: GPUFilter {
    private var brightness: GPUImageBrightnessFilter?

    override init() {
        super.init()
        //设置滤镜名以及默认的强度(0~1)
        identifier = "brightness"
        strength = 0.5
        minValue = -1
        maxValue = 1
    }

    override func startProcess() {
        //新建GPUImage里面的滤镜
        brightness = GPUImageBrightnessFilter.init()
        //将base设置成上述滤镜
        base = brightness
        //启动
        super.startProcess()
    }

    override func stopProcess() {
        super.stopProcess()
    }

    override func onStrengthChanged() {
        //强度回调
        brightness?.brightness = valueFromStrength()
    }
}
