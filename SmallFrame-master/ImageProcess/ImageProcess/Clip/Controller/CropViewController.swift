//
//  CropViewController.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/5.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import SnapKit

// 展示的原图 裁剪的区域 展示图片的区域
typealias CropCompleteBlock = (UIImage,CGRect,CGRect) -> Void
// 裁剪后的图片
typealias CropSucceedBlock = (UIImage) -> Void

// 选择的裁剪模板回调
typealias CropSelectTypeBlock = (Int) -> Void


typealias CropCloseBlock = () -> Void


class CropViewController: UIViewController {
    
   private var tailorView: CATailorView!
    
    var cropImage: UIImage?
    
    var entranceType: EntranceType?
    
    var cropCompleteBlock: CropCompleteBlock?
    
    var cropSucceedBlock: CropSucceedBlock?
    
    var cropCloseBlock: CropCloseBlock?
    
    var cropSelectTypeBlock: CropSelectTypeBlock?
    

    

    // MARK: - lzay
    lazy var cropBottomView: CropBottomView = {
        let cropBottomView = CropBottomView()
        return cropBottomView
    }()
    
    lazy var cropTopFunctionView: AdjustTopFunctionView = {
        let topFunctionView = AdjustTopFunctionView()
        topFunctionView.isHidden = true
        return topFunctionView
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
    }

    // MARK: - set up
    func setupUI(){
        self.view.backgroundColor = UIColor.white
    }

    func addView(){
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 150);
        tailorView = CATailorView(frame: rect)
        tailorView.originalImage = cropImage ?? UIImage(named: "1")!
        view.addSubview(tailorView)
        view.addSubview(cropBottomView)
        view.addSubview(cropTopFunctionView)
    
    }
    
    // MARK: - layout
    func setupLayout(){
        
        cropBottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-10)
            make.height.equalTo(150)
        }
        
        cropTopFunctionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(5 + 40)
            make.height.equalTo(40)
        }

        
    }
    
    
    // MARK: - callBack
    func callBack(){
        
        weak var weakSelf = self
        
 
        
        cropBottomView.cropLeftBtnActionBlock = {
            weakSelf?.navigationController?.popViewController(animated: true)

            if weakSelf?.cropCloseBlock != nil {
                weakSelf?.cropCloseBlock!()
            }

        }
        
        cropBottomView.cropRightBtnActionBlock = {
            
            let cropRect = weakSelf?.tailorView.getTailorImageRect()
            let image = weakSelf?.tailorView.getCurrentShowImage()
            let showRect = weakSelf?.tailorView.getCurrentShowImageFrame()
            let cropImage = weakSelf?.tailorView.getTailorImage()

            if weakSelf?.cropCompleteBlock != nil {
                weakSelf?.cropCompleteBlock!(image!,cropRect!,showRect!)
            }
            
            if weakSelf?.cropSucceedBlock != nil {
                weakSelf?.cropSucceedBlock!(cropImage!)
            }
            weakSelf?.navigationController?.popViewController(animated: true)
            
            
        }
        
        cropBottomView.callBackBlock = { (callBackType) in
            
            if weakSelf?.cropSelectTypeBlock != nil {
                weakSelf?.cropSelectTypeBlock!(callBackType.rawValue)
            }
            
            switch callBackType {
            case .Rotate:
                weakSelf!.tailorView.rotateClick()
            case.Flip:
                weakSelf!.tailorView.verticalFlipAction()
            case.Free:
                weakSelf!.tailorView.resizeWHScale(0.0, height: 0.0)
            case.OneRatioOne:
                weakSelf!.tailorView.resizeWHScale(1.0, height: 1.0)
            case.ThreeRatioFour:
                weakSelf!.tailorView.resizeWHScale(4.0, height: 3.0)
            case.FourRatioThree:
                weakSelf!.tailorView.resizeWHScale(3.0, height: 4.0)
            case.TwoRatioThree:
                weakSelf!.tailorView.resizeWHScale(3.0, height: 2.0)
            case.ThreeRatioTwo:
                weakSelf!.tailorView.resizeWHScale(2.0, height: 3.0)
            case.NineRatioSixteen:
                weakSelf!.tailorView.resizeWHScale(16.0, height: 9.0)
            case.SixteenRatioNine:
                weakSelf!.tailorView.resizeWHScale(9.0, height: 16.0)
            }
            
        }
    }
}
