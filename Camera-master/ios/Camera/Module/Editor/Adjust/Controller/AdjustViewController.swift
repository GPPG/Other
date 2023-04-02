//
//  AdjustViewController.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/5.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

enum SelectFilterType:Int {
    case ExposureFilter = 0
    case ContrastFilter = 1
    case SaturationFilter = 2
    case SharpenFilter = 3
    case VignetteFilter = 4
}

class AdjustViewController: UIViewController {

    var adjustImage: UIImage?
    
    var selectFilterType: SelectFilterType!
    
    // MARK: - lazy
    lazy var adjustBottomView: AdjustBottomContainerView = {
        let adjustBottomView = AdjustBottomContainerView()
        return adjustBottomView
    }()
    
    lazy var adjustTopContainerView: AdjustTopContainerView = {
        let adjustTopContainerView = AdjustTopContainerView()
        return adjustTopContainerView
    }()
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addView()
        setupLayout()
        callBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - set up
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        adjustTopContainerView.adjustImage = adjustImage
    }
    
    func addView(){
        self.view.addSubview(adjustBottomView)
        self.view.addSubview(adjustTopContainerView)
    }
    
    // MARK: - layout
    func setupLayout(){

        adjustBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(180)
        }
        
        adjustTopContainerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(0)
            make.bottom.equalTo(adjustBottomView.snp.top)
        }
        
    }
    
    // MARK: - callBack
    func callBack(){
        
        weak var weakSelf = self
        adjustTopContainerView.topReturnActionBlock = {
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
        adjustTopContainerView.topSaveActionBlock = {
            UIImageWriteToSavedPhotosAlbum(weakSelf!.getCurrentImage(), nil, nil, nil)
        }
        
        adjustTopContainerView.topLastStepActionBlock = {
            
            
        }

        adjustTopContainerView.topNextStepActionBlock = {
            
            
        }
        
        adjustTopContainerView.topDownActionBlock = {
            weakSelf!.adjustTopContainerView.adjustImage = weakSelf!.adjustImage
            
        }

        adjustTopContainerView.topUpActionBlock = {
            weakSelf!.adjustTopContainerView.adjustAfterImage = weakSelf!.getCurrentImage()
        }
        
        adjustBottomView.bottomLeftActionBlock = {
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
        adjustBottomView.bottomRightActionBlock = {
            
            
        }
        
        adjustBottomView.bottomSelectTypeActionBlock = {(indexValue) in
            
            weakSelf?.selectFilterType = SelectFilterType(rawValue: indexValue)
        }
        
        adjustBottomView.bottomSilderActionBlock = { (changValue) in
            
            weakSelf?.handleImage(changValue: changValue)
            
            
        }
        
    }
    
    // MARK: - private
    func handleImage(changValue: Float){
        
        if selectFilterType == SelectFilterType.ExposureFilter {
            
            adjustTopContainerView.adjustAfterImage = AdjustHandleImageManger.handleExposureImage(original: getCurrentImage(), exposure: CGFloat(changValue))
        }
        
        if selectFilterType == SelectFilterType.ContrastFilter {
            
            adjustTopContainerView.adjustAfterImage = AdjustHandleImageManger.handleContrastImage(original: getCurrentImage(), contrast: CGFloat(changValue))
        }
        
        if selectFilterType == SelectFilterType.SaturationFilter {

            adjustTopContainerView.adjustAfterImage = AdjustHandleImageManger.handleSaturationImage(original: getCurrentImage(), saturation: CGFloat(changValue))

        }
        
        if selectFilterType == SelectFilterType.SharpenFilter {
            
            adjustTopContainerView.adjustAfterImage = AdjustHandleImageManger.handleSharpenImage(original: getCurrentImage(), sharpness: CGFloat(changValue))

        }
        
        if selectFilterType == SelectFilterType.VignetteFilter {
            
            adjustTopContainerView.adjustAfterImage = AdjustHandleImageManger.handleVignetteImage(original: getCurrentImage(), vignetteEnd: CGFloat(changValue))

        }
        
    }
    
    func getCurrentImage() -> UIImage {
        var image = adjustImage!
        
        if adjustTopContainerView.adjustAfterImage != nil {
            image = adjustTopContainerView.adjustAfterImage!
        }
        return image
    }
    
    
}
