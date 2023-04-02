//
//  ViewController.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/3.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var tailorView: CATailorView!
    
    lazy var cropBottomView: CropBottomView = {
        let cropBottomView = CropBottomView()
        return cropBottomView
    }()
    
    
    var adjustBottomView: AdjustBottomContainerView!
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addView()
        self.setupLayout()
        callBack()
        
    }

    // MARK: - set up
    func addView(){
        
        
        adjustBottomView = AdjustBottomContainerView()
        self.view.addSubview(adjustBottomView)
        
    
//        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 150);
//        tailorView = CATailorView(frame: rect)
//        tailorView.originalImage = UIImage(named: "Girl")!
        
        
//        self.view.addSubview(tailorView)
//
//        self.view.addSubview(cropBottomView)
    }
    
    // MARK: - layout
    func setupLayout(){
        
        adjustBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        
//        cropBottomView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalTo(self.view)
//            make.height.equalTo(150)
//        }
    }
    
    
    // MARK: - callBack
    func callBack(){
        cropBottomView.callBackBlock = { (callBackType) in
            switch callBackType {
            case .Rotate:
                self.tailorView.rotateClick()
            case.Flip:
                self.tailorView.verticalFlipAction()
            case.Free:
                self.tailorView.resizeWHScale(0.0, height: 0.0)
            case.OneRatioOne:
                self.tailorView.resizeWHScale(1.0, height: 1.0)
            case.ThreeRatioFour:
                self.tailorView.resizeWHScale(3.0, height: 4.0)
            case.FourRatioThree:
                self.tailorView.resizeWHScale(4.0, height: 3.0)
            case.TwoRatioThree:
                self.tailorView.resizeWHScale(2.0, height: 3.0)
            case.ThreeRatioTwo:
                self.tailorView.resizeWHScale(3.0, height: 2.0)
            case.NineRatioSixteen:
                self.tailorView.resizeWHScale(9.0, height: 16.0)
            case.SixteenRatioNine:
                self.tailorView.resizeWHScale(16.0, height: 9.0)
            }
            
        }
        
    }
    
    
}

