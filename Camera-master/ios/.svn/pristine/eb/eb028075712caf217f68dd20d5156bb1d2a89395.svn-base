//
//  Filter.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/22.
//

import Foundation
import GPUImage

/**
 基于GPUImageFilter的包装,暂不支持双通滤镜
 */
class GPUFilter {
    typealias FilterSetupClosure = (GPUImageOutput, GPUImageInput)->Void

    var identifier: String = ""
    /** 强度-0.0~1.0，滤镜起始点不为0时需要设置初始值 */
    var strength: Float = 0{
        didSet{
            onStrengthChanged()
        }
    }

    /** 设置为滤镜的输入部分 */
    var input: GPUImageOutput?
    /** 设置为滤镜的输出目标 */
    var output: GPUImageInput?
    /** 设置为滤镜本身 */
    var base: Any?
    /** 设置为滤镜参数的最小值 */
    var minValue: Float = 0
    /** 设置为滤镜参数的最大值 */
    var maxValue: Float = 1


    var inProcessing: Bool = false

    //必须在子类中调用
    func startProcess(){
        //输入输出不为空
        guard input != nil, output != nil, !inProcessing else{
            return
        }
        //设置输出输入
        guard let inputTarget = base as? GPUImageInput else{
            return
        }
        guard let outputTarget = base as? GPUImageOutput else{
            return
        }
        onStrengthChanged()
        input?.addTarget(inputTarget)
        outputTarget.addTarget(output!)
        inProcessing = true
    }

    //必须在子类中调用
    func stopProcess(){
        guard inProcessing else{
            return
        }
        //移除滤镜输出
        guard let outputTarget = base as? GPUImageOutput else{
            return
        }
        outputTarget.removeAllTargets()
        input?.removeAllTargets()
        inProcessing = false
    }

    //子类中重载，当更改strength时的行为
    func onStrengthChanged(){

    }

    func valueFromStrength() -> CGFloat{
        //从滑动条的0~1映射到min~max
        guard strength >= 0 else{
            return CGFloat(minValue)
        }
        guard strength <= 1 else{
            return CGFloat(maxValue)
        }
        let scale = maxValue - minValue
        let offset = minValue
        let value = strength * scale + offset
        return CGFloat(value)
    }

    /** 在这个方法内对所有GPUImagePicture对象调用processImage */
    func readyForRenderStillImage(){

    }

}
