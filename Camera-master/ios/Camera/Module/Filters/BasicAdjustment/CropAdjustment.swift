//
//  CropAdjustment.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/24.
//

import Foundation

/** 变换调整，不响应强度 */
class CropAdjustment: GPUFilter {
    private var cropFilter: GPUImageCropFilter?
    var cropArea: CGRect = CGRect.init(x: 1, y: 1, width: 1, height: 1){
        didSet{
            cropFilter?.cropRegion = cropArea
        }
    }

    override init() {
        super.init()
        //设置滤镜名以及默认的强度(0~1)
        identifier = "crop"
    }

    override func startProcess() {
        //新建GPUImage里面的滤镜
        cropFilter = GPUImageCropFilter()
        cropFilter?.cropRegion = cropArea
        //将base设置成上述滤镜
        base = cropFilter
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
