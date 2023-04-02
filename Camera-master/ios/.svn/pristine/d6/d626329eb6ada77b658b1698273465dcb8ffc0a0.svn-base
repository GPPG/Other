//
//  CustomGPUCamera.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/20.
//
//  最简易的拍照相机

import Foundation
import GPUImage
import AVFoundation

class LiteCamera: NSObject {
    typealias LitePhotoCaptureCompletition = (UIImage?)->Void

    var videoCamera: GPUImageVideoCamera?

    var renderView: GPUImageView?

    var onPhotoCaptured: LitePhotoCaptureCompletition?

    var precrop: GPUImageCropFilter?

    //设置好renderView之后调用
    func setupCamera(){
        videoCamera = GPUImageVideoCamera.init(preset: .photo, position: .front)

        precrop = GPUImageCropFilter.init()
        let cropRect = CGRect.init(x: 0, y: 0, width: 1, height: 3/4)
        precrop?.cropRegion = cropRect

        videoCamera?.addTarget(precrop)
        precrop?.addTarget(renderView)

        videoCamera?.outputImageOrientation = .portrait
        videoCamera?.horizontallyMirrorFrontFacingCamera = true
        videoCamera?.startCapture()

    }

    //在Disappear调用
    func readyForQuitCamera(){
        videoCamera?.stopCapture()
        videoCamera?.removeAllTargets()
        videoCamera = nil
        GPUImageContext.sharedFramebufferCache()?.purgeAllUnassignedFramebuffers()
    }

    func capturePhoto(complete: @escaping LitePhotoCaptureCompletition){
        //在这里添加HEIF和HEVC的支持
        let setting = AVCapturePhotoSettings.init()
        onPhotoCaptured = complete
        videoCamera?.capturePhoto(with: setting, delegate: self)
    }
}

extension LiteCamera: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        var warpPhoto = OriginPhoto.init(raw: photo, filterGroup: nil)
        warpPhoto.position = videoCamera?.cameraPosition()
        onPhotoCaptured?(warpPhoto.image)
        onPhotoCaptured = nil
    }
}
