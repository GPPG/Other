//
//  CustomGPUCamera.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/20.
//

import Foundation
import GPUImage
import AVFoundation

class Camera: NSObject {
    typealias PhotoCaptureCompletition = (OriginPhoto)->Void

    var videoCamera: GPUImageVideoCamera?

    var group: GPUFilterGroup?

    var renderView: GPUImageView?

    var lutFilter: LookupFilter?

    var flashEnabled: Bool = false

    var onPhotoCaptured: PhotoCaptureCompletition?

    var precrop: GPUImageCropFilter?///temp

    func setupCamera(position: AVCaptureDevice.Position = .front){
        videoCamera = GPUImageVideoCamera.init(preset: .photo, position: position)
        group = GPUFilterGroup.init()

        //crop相对3/4而言
//        let newWidth = 1 / (3.0/4) * (9.0/16)
//        let newX = (1 - newWidth) / 2
//
//        precrop = GPUImageCropFilter.init(cropRegion: CGRect(x: newX, y: 0, width: newWidth, height: 1))
//
//        videoCamera?.addTarget(precrop)

        group?.input = videoCamera
        group?.output = renderView

        group?.startProcess()

        videoCamera?.outputImageOrientation = .portrait
        videoCamera?.horizontallyMirrorFrontFacingCamera = true
        videoCamera?.startCapture()

    }
    
    func setSquareTarget() {
        precrop = GPUImageCropFilter.init(cropRegion: CGRect(x: 0, y: 0, width: 1, height: 1))
        videoCamera?.addTarget(precrop)
    }

    func readyForQuitCamera(){
        for filter in videoCamera!.targets(){
            (filter as? GPUImageFilter)?.removeAllTargets()
        }
        group?.stopProcess()
        videoCamera?.stopCapture()
        videoCamera?.removeAllTargets()
        videoCamera = nil
        GPUImageContext.sharedFramebufferCache()?.purgeAllUnassignedFramebuffers()
    }

    func rotateCamera(){
        videoCamera?.rotateCamera()
    }

    func toggleFlashlight() -> Bool{
        if flashEnabled == true{
            flashEnabled = false
            return false
        } else{
            flashEnabled = true
            return true
        }
    }

    func capturePhoto(complete: @escaping PhotoCaptureCompletition){
        //在这里添加HEIF和HEVC的支持
        let setting = AVCapturePhotoSettings.init()
        setting.flashMode = flashEnabled ? .on : .off
        onPhotoCaptured = complete
        videoCamera?.capturePhoto(with: setting, delegate: self)
    }
}

extension Camera: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        //内存占用较大
        videoCamera?.cameraPosition()
        var warpPhoto = OriginPhoto.init(raw: photo, filterGroup: group!)
        warpPhoto.position = videoCamera?.cameraPosition()
        onPhotoCaptured?(warpPhoto)
        onPhotoCaptured = nil
    }
}

// - MARK: LUT
extension Camera{
    func addLutFilter(name: String){
        lutFilter = group?.getFilter(identifier: "lookup") as? LookupFilter
        if lutFilter == nil{
            lutFilter = LookupFilter.init()
            group?.addFilter(lutFilter!)
        }
        lutFilter?.lookupImage = FilterDataManager.shared.getLutImage(name)
        lutFilter?.strength = 0.8
    }
}
