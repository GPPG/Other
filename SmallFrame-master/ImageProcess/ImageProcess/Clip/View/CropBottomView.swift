//
//  CropBottomView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/3.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit


typealias CropLeftBtnActionBlock = () -> Void
typealias CropRightBtnActionBlock = () -> Void

class CropBottomView: UIView {
    
    public enum CallBackType: Int {
        case Rotate = 10
        case Flip = 11
        case Free = 0
        case OneRatioOne = 1
        case ThreeRatioFour = 2
        case FourRatioThree = 3
        case TwoRatioThree = 4
        case ThreeRatioTwo = 5
        case NineRatioSixteen = 6
        case SixteenRatioNine = 7
    }
    
    typealias CallBackBlock = (CallBackType) -> Void
    var callBackBlock: CallBackBlock?
    var cropLeftBtnActionBlock:CropLeftBtnActionBlock?
    var cropRightBtnActionBlock:CropRightBtnActionBlock?
    var entranceType: EntranceType?
    
    // MARK: - lazy
    lazy var bottomView: AdjustBottomView = {
        let bottomView = AdjustBottomView()
        bottomView.leftImageStr = "icon-close"
        bottomView.rightImageStr = "icon-yes"
        bottomView.tipLabelStr = "裁剪"
        return bottomView
    }()
    
    lazy var bottomLeftView: UIView = {
        let bottomLeftView = UIView()
        return bottomLeftView
    }()
    
    
    lazy var bottomRightView: CropBottomRightView = {
        let bottomRightView = CropBottomRightView()
        bottomRightView.entranceType = .CropEntrance
        return bottomRightView
    }()
    
    lazy var rotateView: CropTipBtnView = {
        let rotateView = CropTipBtnView()
        rotateView.tipBtn.setImage(UIImage(named: "icon-rotate"), for: UIControl.State.normal)
        rotateView.tipLabel.text = "旋转"
        return rotateView
    }()
    
    lazy var flipView: CropTipBtnView = {
        let flipView = CropTipBtnView()
        flipView.tipBtn.setImage(UIImage(named: "icon-flip"), for: UIControl.State.normal)
        flipView.tipLabel.text = "翻转"
        return flipView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        return lineView
    }()
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupLayout()
        callBack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        
        addSubview(bottomView)
        addSubview(bottomLeftView)
        bottomLeftView.addSubview(rotateView)
        bottomLeftView.addSubview(flipView)
        bottomLeftView.addSubview(lineView)
        addSubview(bottomRightView)
    }
    
    // MARK: - call back
    func callBack(){
        weak var weakSelf = self
        bottomView.leftBtnActionBlock = {
            if weakSelf!.cropLeftBtnActionBlock != nil {
                weakSelf!.cropLeftBtnActionBlock!()
            }
        }
        
        bottomView.rightBtnActionBlock = {
            if weakSelf!.cropRightBtnActionBlock != nil {
                weakSelf!.cropRightBtnActionBlock!()
            }
        }
        
        rotateView.tipBtnActionBlock = {
            weakSelf!.callBackType = .Rotate
        }
        
        flipView.tipBtnActionBlock = {
            weakSelf!.callBackType = .Flip
        }
        
        bottomRightView.scaleActionBlock = { (rowValue,enterType) in
            
            switch enterType {
            case .CropEntrance:
            weakSelf?.scaleCropAction(rowValue: rowValue)
            case .MagEntrance:
            weakSelf?.scaleMagAction(rowValue: rowValue)
            }
        }
    }
    
    // MARK: - private
    func scaleCropAction(rowValue: Int){
        
        switch rowValue {
        case 0:
            self.callBackType = .Free
        case 1:
            self.callBackType = .OneRatioOne
        case 2:
            self.callBackType = .ThreeRatioFour
        case 3:
            self.callBackType = .FourRatioThree
        case 4:
            self.callBackType = .TwoRatioThree
        case 5:
            self.callBackType = .ThreeRatioTwo
        case 6:
            self.callBackType = .NineRatioSixteen
        case 7:
            self.callBackType = .SixteenRatioNine
        default:
            self.callBackType = .Free
        }
    }
    func scaleMagAction(rowValue: Int){
        
        switch rowValue {
        case 0:
            self.callBackType = .FourRatioThree
        default:
            self.callBackType = .FourRatioThree
        }
    }


    
    // MARK: - set
    var callBackType: CallBackType!{
    didSet{
        if callBackBlock != nil {
            callBackBlock!(callBackType)
            }
        }
    }
    
    // MARK: - layout
    func setupLayout(){
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(50)
        }
        
        bottomLeftView.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.left.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(10)
            make.height.equalTo(100)
        }
        
        rotateView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLeftView).offset(21)
            make.width.equalTo(40)
            make.top.bottom.equalToSuperview()
        }
        
        flipView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(40)
            make.left.equalTo(rotateView.snp.right).offset(25)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(1.5)
            make.height.equalTo(16.5)
            make.centerY.equalTo(bottomLeftView).offset(-15)
            make.left.equalTo(flipView.snp.right).offset(20)
        }
        
        bottomRightView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLeftView.snp.right).offset(25)
            make.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(10)
            make.height.equalTo(bottomLeftView)
            
        }
        
    }
    
}



