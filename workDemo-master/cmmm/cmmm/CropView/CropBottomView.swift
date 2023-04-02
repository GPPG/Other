//
//  CropBottomView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/3.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit



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
    
    
    // MARK: - lazy
    lazy var bottomView: UIView = {
        let bottomView = UIView()
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
    
    lazy var closeBtn: UIButton = {
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named: "icon-adjust"), for: UIControl.State.normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return closeBtn
    }()
    
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton()
        sureBtn.setImage(UIImage(named: "icon-adjust"), for: UIControl.State.normal)
        sureBtn.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        return sureBtn
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "CROP"
        tipLabel.textColor = UIColor.black
        tipLabel.font = UIFont.systemFont(ofSize: 17)
        tipLabel.textAlignment = NSTextAlignment.center
        return tipLabel
    }()
    
    lazy var rotateView: CropTipBtnView = {
        let rotateView = CropTipBtnView()
        rotateView.tipBtn.setImage(UIImage(named: "icon-adjust"), for: UIControl.State.normal)
        rotateView.tipLabel.text = "Rotate"
        return rotateView
    }()
    
    lazy var flipView: CropTipBtnView = {
        let flipView = CropTipBtnView()
        flipView.tipBtn.setImage(UIImage(named: "icon-adjust"), for: UIControl.State.normal)
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
        self.addView()
        self.setupLayout()
        callBack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        
        self.addSubview(bottomView)
        self.bottomView.addSubview(sureBtn)
        self.bottomView.addSubview(closeBtn)
        self.bottomView.addSubview(tipLabel)
        
        self.addSubview(bottomLeftView)
        self.bottomLeftView.addSubview(rotateView)
        self.bottomLeftView.addSubview(flipView)
        self.bottomLeftView.addSubview(lineView)
        
        self.addSubview(bottomRightView)
        
    }
    
    
    
    
    // MARK: - action
    @objc func closeAction(){
        
    }
    
    @objc func sureAction(){
        
        
    }
    
    // MARK: - call back
    func callBack(){
        
        rotateView.tipBtnActionBlock = {
            self.callBackType = .Rotate
        }
        
        flipView.tipBtnActionBlock = {
            self.callBackType = .Flip
        }
        
        bottomRightView.scaleActionBlock = { (rowValue) in
            
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
        
        closeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.bottomView).offset(37.5)
            make.centerY.equalTo(self.bottomView)
            make.width.height.equalTo(25)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.bottomView).offset(-37.5)
            make.centerY.equalTo(self.bottomView)
            make.width.height.equalTo(25)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(closeBtn.snp_rightMargin)
            make.right.equalTo(sureBtn.snp_leftMargin)
        }
        
        bottomLeftView.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.left.equalToSuperview()
            make.bottom.equalTo(bottomView.snp_topMargin).offset(10)
            make.height.equalTo(100)
        }
        
        rotateView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLeftView).offset(21)
            make.bottom.top.equalToSuperview()
            make.width.equalTo(40)
        }
        
        flipView.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.width.equalTo(40)
            make.left.equalTo(rotateView.snp_rightMargin).offset(25)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(1.5)
            make.height.equalTo(16.5)
            make.centerY.equalTo(bottomLeftView).offset(-15)
            make.left.equalTo(flipView.snp_rightMargin).offset(25)
        }
        
        
        bottomRightView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLeftView.snp_rightMargin).offset(25)
            make.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp_topMargin).offset(10)
            make.height.equalTo(bottomLeftView)
            
        }
        
    }
    
}



