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
    
    public enum CallBackType {
        case Rotate
        case Flip
        case Free
        case OneRatioOne
        case ThreeRatioFour
        case FourRatioThree
        case TwoRatioThree
        case ThreeRatioTwo
        case NineRatioSixteen
        case SixteenRatioNine
    }
    
    typealias CallBackBlock = (CallBackType) -> Void
    var callBackBlock: CallBackBlock?
    var cropLeftBtnActionBlock:CropLeftBtnActionBlock?
    var cropRightBtnActionBlock:CropRightBtnActionBlock?

    
    // MARK: - lazy
    lazy var bottomView: AdjustBottomView = {
        let bottomView = AdjustBottomView()
        bottomView.leftImageStr = "icon-close"
        bottomView.rightImageStr = "icon-yes"
        bottomView.tipLabelStr = "CROP"
        return bottomView
    }()
    
    lazy var bottomLeftView: UIView = {
        let bottomLeftView = UIView()
        return bottomLeftView
    }()
    
    
    lazy var bottomRightView: CropBottomRightView = {
        let bottomRightView = CropBottomRightView()
        return bottomRightView
    }()
    
    lazy var rotateView: CropTipBtnView = {
        let rotateView = CropTipBtnView()
        rotateView.tipBtn.setImage(UIImage(named: "icon-rotate"), for: UIControl.State.normal)
        rotateView.tipLabel.text = "Rotate"
        return rotateView
    }()
    
    lazy var flipView: CropTipBtnView = {
        let flipView = CropTipBtnView()
        flipView.tipBtn.setImage(UIImage(named: "icon-flip"), for: UIControl.State.normal)
        flipView.tipLabel.text = "Flip"
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
        
        bottomRightView.scaleActionBlock = { (rowValue) in
            
            switch rowValue {
            case 0:
                weakSelf!.callBackType = .Free
            case 1:
                weakSelf!.callBackType = .OneRatioOne
            case 2:
                weakSelf!.callBackType = .ThreeRatioFour
            case 3:
                weakSelf!.callBackType = .FourRatioThree
            case 4:
                weakSelf!.callBackType = .TwoRatioThree
            case 5:
                weakSelf!.callBackType = .ThreeRatioTwo
            case 6:
                weakSelf!.callBackType = .NineRatioSixteen
            case 7:
                weakSelf!.callBackType = .SixteenRatioNine
            default:
                weakSelf!.callBackType = .Free
            }
            
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



