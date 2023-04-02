//
//  GPUImage+Pipeline.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/21.
//

import Foundation
import GPUImage

infix operator --> : AdditionPrecedence

extension GPUImageOutput{
    @discardableResult
    static func --> (left: GPUImageOutput, right: GPUImageInput) -> GPUImageInput{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageOutput, right: GPUImageFilter) -> GPUImageFilter{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageOutput, right: GPUImageFilterGroup) -> GPUImageFilterGroup{
        left.addTarget(right)
        return right
    }
}

extension GPUImageFilter{
    @discardableResult
    static func --> (left: GPUImageFilter, right: GPUImageInput) -> GPUImageInput{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageFilter, right: GPUImageFilter) -> GPUImageFilter{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageFilter, right: GPUImageFilterGroup) -> GPUImageFilterGroup{
        left.addTarget(right)
        return right
    }
}

extension GPUImageFilterGroup{
    @discardableResult
    static func --> (left: GPUImageFilterGroup, right: GPUImageInput) -> GPUImageInput{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageFilterGroup, right: GPUImageFilterGroup) -> GPUImageFilterGroup{
        left.addTarget(right)
        return right
    }

    @discardableResult
    static func --> (left: GPUImageFilterGroup, right: GPUImageFilter) -> GPUImageFilter{
        left.addTarget(right)
        return right
    }
}
