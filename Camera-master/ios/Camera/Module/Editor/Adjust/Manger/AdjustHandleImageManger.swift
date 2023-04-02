//
//  AdjustHandleImageManger.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/6.
//

import UIKit



class AdjustHandleImageManger: NSObject {

   class func handleExposureImage(original: UIImage,exposure: CGFloat) -> UIImage {

        let exposureFilter = GPUImageExposureFilter()
        exposureFilter.exposure = exposure
        exposureFilter.forceProcessing(at: original.size)
        exposureFilter.useNextFrameForImageCapture()
        
        let pic = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        pic!.addTarget(exposureFilter)
        pic!.processImage()
        
        let tempImage = exposureFilter.imageFromCurrentFramebuffer()
        
        return tempImage!
    }
    
    class  func handleContrastImage(original: UIImage,contrast: CGFloat) -> UIImage {
        
        let contrastFilter = GPUImageContrastFilter()
        contrastFilter.contrast = contrast
        contrastFilter.forceProcessing(at: original.size)
        contrastFilter.useNextFrameForImageCapture()
        
        let pic = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        pic!.addTarget(contrastFilter)
        pic!.processImage()
        
        let tempImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return tempImage!
    }
    
    class  func handleSaturationImage(original: UIImage,saturation: CGFloat) -> UIImage {
        
        let saturationFilter = GPUImageSaturationFilter()
        saturationFilter.saturation = saturation
        saturationFilter.forceProcessing(at: original.size)
        saturationFilter.useNextFrameForImageCapture()
        
        let pic = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        pic!.addTarget(saturationFilter)
        pic!.processImage()
        
        let tempImage = saturationFilter.imageFromCurrentFramebuffer()
        
        return tempImage!
    }
    
    class  func handleSharpenImage(original: UIImage,sharpness: CGFloat) -> UIImage {
        
        let sharpenFilter = GPUImageSharpenFilter()
        sharpenFilter.sharpness = sharpness
        sharpenFilter.forceProcessing(at: original.size)
        sharpenFilter.useNextFrameForImageCapture()
        
        let pic = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        pic!.addTarget(sharpenFilter)
        pic!.processImage()
        
        let tempImage = sharpenFilter.imageFromCurrentFramebuffer()
        
        return tempImage!
    }

    class  func handleVignetteImage(original: UIImage,vignetteEnd: CGFloat) -> UIImage {
        
        let vignetteFilter = GPUImageVignetteFilter()
        vignetteFilter.vignetteEnd = vignetteEnd
        vignetteFilter.forceProcessing(at: original.size)
        vignetteFilter.useNextFrameForImageCapture()
        
        let pic = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        pic!.addTarget(vignetteFilter)
        pic!.processImage()
        
        let tempImage = vignetteFilter.imageFromCurrentFramebuffer()
        
        return tempImage!
    }


    
}
