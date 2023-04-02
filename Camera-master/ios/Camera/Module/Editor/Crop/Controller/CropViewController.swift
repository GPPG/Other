//
//  CropViewController.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/5.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import SnapKit

class CropViewController: UIViewController {
    
   private var tailorView: CATailorView!
    
    var cropImage: UIImage?
    
    // MARK: - lzay
    lazy var cropBottomView: CropBottomView = {
        let cropBottomView = CropBottomView()
        return cropBottomView
    }()
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addView()
        setupLayout()
        callBack()
    }
    
    // MARK: - set up
    func setupUI(){
        self.view.backgroundColor = UIColor.white
    }

    func addView(){
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 150);
        tailorView = CATailorView(frame: rect)
        tailorView.originalImage = cropImage ?? UIImage(named: "mask-fortunecamera")!
        self.view.addSubview(tailorView)
        self.view.addSubview(cropBottomView)
    }
    
    // MARK: - layout
    func setupLayout(){
        
        cropBottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-10)
            make.height.equalTo(150)
        }
    }
    
    
    // MARK: - callBack
    func callBack(){
        
        weak var weakSelf = self
        cropBottomView.cropLeftBtnActionBlock = {
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
        cropBottomView.cropRightBtnActionBlock = {
            
        }
        
        cropBottomView.callBackBlock = { (callBackType) in
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
                weakSelf!.tailorView.resizeWHScale(3.0, height: 4.0)
            case.FourRatioThree:
                weakSelf!.tailorView.resizeWHScale(4.0, height: 3.0)
            case.TwoRatioThree:
                weakSelf!.tailorView.resizeWHScale(2.0, height: 3.0)
            case.ThreeRatioTwo:
                weakSelf!.tailorView.resizeWHScale(3.0, height: 2.0)
            case.NineRatioSixteen:
                weakSelf!.tailorView.resizeWHScale(9.0, height: 16.0)
            case.SixteenRatioNine:
                weakSelf!.tailorView.resizeWHScale(16.0, height: 9.0)
            }
        }
    }
}
