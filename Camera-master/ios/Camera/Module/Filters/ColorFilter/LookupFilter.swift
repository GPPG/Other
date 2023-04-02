//
//  LookupFilter.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/24.
//

import Foundation

/** 基础的LUT滤镜 */
class LookupFilter: GPUFilter {
    var lookup: GPUImageLookupFilter?
    var lookupGpuImage: GPUImagePicture?
    var lookupImage: UIImage?{
        didSet{
            refreshLookupImage()
        }
    }

    override init() {
        super.init()
        //设置滤镜名以及默认的强度(0~1)
        identifier = "lookup"
        strength = 0.5
    }

    override func startProcess() {
        //新建GPUImage里面的滤镜
        lookup = GPUImageLookupFilter.init()
//        lookup?.framebufferForOutput()?.disableReferenceCounting()
        //将base设置成上述滤镜
        base = lookup
        //启动
        super.startProcess()
        refreshLookupImage()
    }

    override func stopProcess() {
        super.stopProcess()
    }

    func refreshLookupImage(){
        if lookupGpuImage?.targets()?.count ?? 0 > 0 {
            lookupGpuImage?.removeAllTargets()
        }
        guard lookupImage != nil else{
            return
        }
        lookupGpuImage = GPUImagePicture.init(image: lookupImage)
        guard lookup != nil else {
            return
        }
//        lookupGpuImage?.framebufferForOutput()?.disableReferenceCounting()
        lookupGpuImage?.addTarget(lookup!, atTextureLocation: 1)
        lookupGpuImage?.processImage()
    }

    override func onStrengthChanged() {
        //强度回调
        lookup?.intensity = CGFloat(strength)
        lookupGpuImage?.processImage()
    }

    override func readyForRenderStillImage() {
        lookupGpuImage?.processImage()
    }
}
