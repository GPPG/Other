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

typealias DisposeCompleteBlock = (UIImage) -> Void

class AdjustViewController: UIViewController {
    

    var disposeCompleteBlock:DisposeCompleteBlock?
    
    
    var selectFilterType: SelectFilterType!
    
    var adjustModeArray = [AdjustTypeMode.init(value: CGFloat(ExposureFilterNormalValue), filterType: .ExposureFilter),
                           AdjustTypeMode.init(value: CGFloat(ContrastFilterNormalValue), filterType: .ContrastFilter),
                           AdjustTypeMode.init(value: CGFloat(SaturationFilterNormalValue), filterType: .SaturationFilter),
                           AdjustTypeMode.init(value: CGFloat(SharpenFilterNormalValue), filterType: .SharpenFilter),
                           AdjustTypeMode.init(value: CGFloat(VignetteFilterNormalValue), filterType: .VignetteFilter)]
    
    // last next 缓存数据
    fileprivate var slectAdjustArray: Array<Array<AdjustTypeMode>> = Array.init()
    
    fileprivate var slectAdjustModeArray: Array<AdjustTypeMode> = Array.init()
    
    fileprivate var lastSelectFilterType : SelectFilterType?
    
    fileprivate var currentslectMag: Int?
    
    

    
    // MARK: - lazy
    lazy var adjustBottomView: AdjustBottomContainerView = {
        let adjustBottomView = AdjustBottomContainerView()
        return adjustBottomView
    }()
    
    lazy var adjustTopContainerView: AdjustTopContainerView = {
        let adjustTopContainerView = AdjustTopContainerView()
        adjustBottomView.adjustEnterType = .AdjustType
        return adjustTopContainerView
    }()
    
    lazy var adjustMainHandleImageManger: AdjustMainHandleImageManger? = {
        let adjustMainHandleImageManger = AdjustMainHandleImageManger()
        return adjustMainHandleImageManger
    }()
    
    
    let semaphore = DispatchSemaphore.init(value: 3)
    
    
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
        
    }
    deinit {
    }
    
    
    // MARK: - set
    var adjustImage: UIImage?{
        didSet{
            adjustTopContainerView.adjustImage = adjustImage
        }
    }
    
    // MARK: - set up
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        
        
        selectFilterType = .ExposureFilter
        
        // 前进,后退,缓存的数据
        addSlectAdjust()
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
            weakSelf?.navigationController?.popViewController(animated: true)
        }
        
        adjustTopContainerView.topSaveActionBlock = {

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
            weakSelf?.resetLastData()
            
            weakSelf?.navigationController?.popViewController(animated: true)
        }
        
        adjustBottomView.bottomRightActionBlock = {
            
            if (weakSelf?.disposeCompleteBlock != nil) {
                weakSelf?.disposeCompleteBlock!(weakSelf!.getCurrentImage())
            }
            weakSelf?.resetLastData()
            weakSelf?.navigationController?.popViewController(animated: true)
            
        }
        
        adjustBottomView.bottomSelectTypeActionBlock = {(indexValue) in
            
            weakSelf?.selectFilterType = SelectFilterType(rawValue: indexValue)
            weakSelf?.addSlectAdjust()
            weakSelf?.currentslectMag = (weakSelf?.slectAdjustArray.count)! - 1
        }
        
        adjustBottomView.bottomSilderActionBlock = { (changValue) in
            
            weakSelf?.handleImage(changValue: changValue)
        }
        
        
        adjustBottomView.bottomSilderInsideActionBlock = { (changValue) in
            weakSelf?.updateSlectAdjustArray()
        }
        
    }
    
    // MARK: - private
    
    func pushShareVC(image: UIImage){
    }
    
    func handleImage(changValue: Float){
        
        if selectFilterType == SelectFilterType.ExposureFilter {
            
            adjustModeArray[selectFilterType.rawValue] = AdjustTypeMode.init(value: CGFloat(changValue), filterType: .ExposureFilter)
            
            handImage()
            
        }
        
        if selectFilterType == SelectFilterType.ContrastFilter {
            
            adjustModeArray[selectFilterType.rawValue] = AdjustTypeMode.init(value: CGFloat(changValue), filterType: .ContrastFilter)
            handImage()

            }
        
        if selectFilterType == SelectFilterType.SaturationFilter {
            
            adjustModeArray[selectFilterType.rawValue] = AdjustTypeMode.init(value: CGFloat(changValue), filterType: .SaturationFilter)
            handImage()

            
        }
        
        if selectFilterType == SelectFilterType.SharpenFilter {
            adjustModeArray[selectFilterType.rawValue] = AdjustTypeMode.init(value: CGFloat(changValue), filterType: .SharpenFilter)
            handImage()

        }
        
        if selectFilterType == SelectFilterType.VignetteFilter {
            adjustModeArray[selectFilterType.rawValue] = AdjustTypeMode.init(value: CGFloat(changValue), filterType: .VignetteFilter)
            handImage()

        }
        
    }
    
    func getCurrentImage() -> UIImage {
        var image = adjustImage!
        
        if adjustTopContainerView.adjustAfterImage != nil {
            image = adjustTopContainerView.adjustAfterImage!
        }
        return image
    }
    
    func handImage(){
        
        let qq = DispatchQueue.global()
        
        qq.async {
            
            self.semaphore.wait()
            
            let imagee = self.adjustMainHandleImageManger!.handleAdjustImage(original: self.adjustImage!, valueArray: self.adjustModeArray)
            DispatchQueue.main.async {
                if imagee != self.adjustImage{
                    self.adjustTopContainerView.adjustAfterImage = imagee
                }
            }
            self.semaphore.signal()
        }

    }
    
}


// MARK: - last next
extension AdjustViewController{
    
    
    func addSlectAdjust(){

        if selectFilterType != lastSelectFilterType {
            

            slectAdjustModeArray.append(adjustModeArray[selectFilterType.rawValue])
            slectAdjustArray.append(adjustModeArray)
            
            lastSelectFilterType = selectFilterType

            
        }
    }
    
    func updateSlectAdjustArray(){
        
        if slectAdjustModeArray.count != 0 {
            slectAdjustModeArray.removeLast()
        }
        
        slectAdjustModeArray.append(adjustModeArray[selectFilterType.rawValue])
        
        if slectAdjustArray.count != 0 {
            slectAdjustArray.removeLast()
        }
        slectAdjustArray.append(adjustModeArray)
    }
    
    

    
    
    
    func updateSliderUI(){
        
        adjustBottomView.updateTypeUI(mode: slectAdjustModeArray[currentslectMag!])
    }
    
    func resetLastData(){
        
        currentslectMag = nil
        slectAdjustArray.removeAll()
        slectAdjustModeArray.removeAll()
    }
    
}
