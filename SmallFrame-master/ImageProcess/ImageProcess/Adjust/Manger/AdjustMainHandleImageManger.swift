//
//  AdjustMainHandleImageManger.swift
//  SelfieCamera
//
//  Created by 郭鹏 on 2019/7/10.
//

import UIKit

class AdjustMainHandleImageManger: NSObject {

    var tempImage: UIImage?
    
    func handleAdjustImage(original: UIImage,valueArray: [AdjustTypeMode]) -> UIImage {
    
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
        
        let ii  =  myFilterGroup.imageFromCurrentFramebuffer()
        
        if ii != nil {
            tempImage = ii
        }
        return tempImage ?? original
    }

    
     func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func printCurrentThread(with des: String, _ terminator: String = "") {

    }
    
    
    func addGPUImageFilter(filter: GPUImageFilter,myFilterGroup:GPUImageFilterGroup){
        
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
    
    
}
