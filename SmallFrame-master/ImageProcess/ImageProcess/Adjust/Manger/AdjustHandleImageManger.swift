//
//  AdjustHandleImageManger.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/6.
//

import UIKit



let ExposureFilterMaxValue: Float = 0.5
let ExposureFilterMinValue: Float = -0.5
let ExposureFilterNormalValue: Float = 0

let ExposureEditFilterNormalValue: Float = 0.5


let ContrastFilterMaxValue: Float = 1.5
let ContrastFilterMinValue: Float = 0.5
let ContrastFilterNormalValue: Float = 1

let ContrastEditFilterNormalValue: Float = 0.5


let SaturationFilterMaxValue: Float = 1.5
let SaturationFilterMinValue: Float = 0.5
let SaturationFilterNormalValue: Float = 1

let SaturationEditFilterNormalValue: Float = 0.5


let SharpenFilterMaxValue: Float = 2
let SharpenFilterMinValue: Float = 0
let SharpenFilterNormalValue: Float = 0

let SharpenEditFilterNormalValue: Float = 0


let VignetteFilterMaxValue: Float = 1
let VignetteFilterMinValue: Float = 0.7
let VignetteFilterNormalValue: Float = 0.7

// min - x + max
let VignetteEditFilterNormalValue: Float = 0





class AdjustHandleImageManger: NSObject {
    
    class func handleAdjustImage(original: UIImage,valueArray: [AdjustTypeMode],imageView: UIImageView){
        
        var eValue:CGFloat?
        var conValue:CGFloat?
        var satValue:CGFloat?
        var shaValue:CGFloat?
        var vigValue:CGFloat?
        
        
        for mode in valueArray {
            
            if mode.selectFilterType == SelectFilterType.ExposureFilter{
                eValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.ContrastFilter{
                conValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.SaturationFilter{
                satValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.SharpenFilter{
                shaValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.VignetteFilter{
                var value = CGFloat(VignetteFilterMinValue - Float(mode.selectValue) + VignetteFilterMaxValue)
                if value == CGFloat(VignetteFilterMaxValue){
                    value = 5
                }
                vigValue = value
            }
            
            
        }
        let qq = DispatchQueue.global()
        
        qq.async {
            
            let picture = GPUImagePicture(image: original, smoothlyScaleOutput: true)
            
            let myFilterGroup = GPUImageFilterGroup()
            picture!.addTarget(myFilterGroup)
            
            // 添加滤镜
            let exposureFilter = GPUImageExposureFilter()
            exposureFilter.exposure = eValue!
            
            let contrastFilter = GPUImageContrastFilter()
            contrastFilter.contrast = conValue!
            
            let saturationFilter = GPUImageSaturationFilter()
            saturationFilter.saturation = satValue!
            
            let sharpenFilter = GPUImageSharpenFilter()
            sharpenFilter.sharpness = shaValue!
            
            let vignetteFilter = GPUImageVignetteFilter()
            vignetteFilter.vignetteEnd = vigValue!
            
            addGPUImageFilter(filter: exposureFilter, myFilterGroup: myFilterGroup)
            addGPUImageFilter(filter: contrastFilter, myFilterGroup: myFilterGroup)
            addGPUImageFilter(filter: saturationFilter, myFilterGroup: myFilterGroup)
            addGPUImageFilter(filter: sharpenFilter, myFilterGroup: myFilterGroup)
            addGPUImageFilter(filter: vignetteFilter, myFilterGroup: myFilterGroup)
            picture!.processImage()
            
            DispatchQueue.main.async {
                imageView.image =  myFilterGroup.imageFromCurrentFramebuffer()
            }
        }
    }

    
    
    class func handleAdjustImage(original: UIImage,valueArray: [AdjustTypeMode]) -> UIImage {
        
    
        var eValue:CGFloat?
        var conValue:CGFloat?
        var satValue:CGFloat?
        var shaValue:CGFloat?
        var vigValue:CGFloat?
        
        
        for mode in valueArray {
            
            if mode.selectFilterType == SelectFilterType.ExposureFilter{
                eValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.ContrastFilter{
                conValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.SaturationFilter{
                satValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.SharpenFilter{
                shaValue = mode.selectValue
            }
            
            if mode.selectFilterType == SelectFilterType.VignetteFilter{
                var value = CGFloat(VignetteFilterMinValue - Float(mode.selectValue) + VignetteFilterMaxValue)
                if value == CGFloat(VignetteFilterMaxValue){
                    value = 5
                }
                vigValue = value
            }
            
            
        }
        
        
        let picture = GPUImagePicture(image: original, smoothlyScaleOutput: true)
        
        let myFilterGroup = GPUImageFilterGroup()
        picture!.addTarget(myFilterGroup)
        
        // 添加滤镜
        let exposureFilter = GPUImageExposureFilter()
        exposureFilter.exposure = eValue!
        
        let contrastFilter = GPUImageContrastFilter()
        contrastFilter.contrast = conValue!
        
        let saturationFilter = GPUImageSaturationFilter()
        saturationFilter.saturation = satValue!
        
        let sharpenFilter = GPUImageSharpenFilter()
        sharpenFilter.sharpness = shaValue!
        
        let vignetteFilter = GPUImageVignetteFilter()
        vignetteFilter.vignetteEnd = vigValue!
        
        addGPUImageFilter(filter: exposureFilter, myFilterGroup: myFilterGroup)
        addGPUImageFilter(filter: contrastFilter, myFilterGroup: myFilterGroup)
        addGPUImageFilter(filter: saturationFilter, myFilterGroup: myFilterGroup)
        addGPUImageFilter(filter: sharpenFilter, myFilterGroup: myFilterGroup)
        addGPUImageFilter(filter: vignetteFilter, myFilterGroup: myFilterGroup)
        
        
        picture!.processImage()
        myFilterGroup.useNextFrameForImageCapture()
        
        printCurrentThread(with: "当前线程")
        
        
        return myFilterGroup.imageFromCurrentFramebuffer() ?? original

}
    
 
    
   class func printCurrentThread(with des: String, _ terminator: String = "") {
    }
    

    
   class func addGPUImageFilter(filter: GPUImageFilter,myFilterGroup:GPUImageFilterGroup){
        
        myFilterGroup.addFilter(filter)
        
        let newTerminalFilter = filter
        
        let count = myFilterGroup.filterCount()
        
        if count == 1 {
            
            myFilterGroup.initialFilters = [newTerminalFilter]
            myFilterGroup.terminalFilter = newTerminalFilter
        }else{
            
            let terminalFilter = myFilterGroup.terminalFilter
            let initialFilters = myFilterGroup.initialFilters
            
            terminalFilter?.addTarget(newTerminalFilter)
            
            myFilterGroup.initialFilters = [initialFilters![0]]
            myFilterGroup.terminalFilter = newTerminalFilter
            
            
        }
        
        
        
        
        
    }
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
