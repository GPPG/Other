//
//  TransformAdjustment.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/23.
//

import Foundation

/** 变换调整，不响应强度 */
class TransformAdjustment: GPUFilter {
    private var transformFilter: GPUImageTransformFilter?
    var transform: CGAffineTransform?{
        get{
            return transformFilter?.affineTransform
        }
        set{
            if let value = newValue{
                transformFilter?.affineTransform = value
            }

        }
    }

    override init() {
        super.init()
        //设置滤镜名以及默认的强度(0~1)
        identifier = "transform"
    }

    override func startProcess() {
        //新建GPUImage里面的滤镜
        transformFilter = GPUImageTransformFilter.init()
        //将base设置成上述滤镜
        base = transformFilter
        //启动
        super.startProcess()
    }

    override func stopProcess() {
        super.stopProcess()
    }

    override func onStrengthChanged() {
        //强度回调
    }
}
