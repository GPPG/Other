//
//  AdjustTopContainerView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/5.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias TopReturnActionBlock = () -> Void
typealias TopSaveActionBlock = () -> Void
typealias TopLastStepActionBlock = () -> Void
typealias TopNextStepActionBlock = () -> Void
typealias TopDownActionBlock = () -> Void
typealias TopUpActionBlock = () -> Void



class AdjustTopContainerView: UIView {
    
    var topReturnActionBlock:TopReturnActionBlock?
    var topSaveActionBlock:TopSaveActionBlock?
    var topLastStepActionBlock:TopLastStepActionBlock?
    var topNextStepActionBlock:TopNextStepActionBlock?
    var topDownActionBlock:TopDownActionBlock?
    var topUpActionBlock:TopUpActionBlock?
    
    var exposureFilter:GPUImageBrightnessFilter!
    var pic:GPUImagePicture!
    
    

    // MARK: - set
    var adjustImage: UIImage?{
        didSet{
            guard adjustImage != nil else { return }
            
            imageView.image = adjustImage
            
         

        }
    }

    var adjustAfterImage: UIImage?{
        didSet{
            guard adjustAfterImage != nil else { return }
            imageView.image = adjustAfterImage
            
            


        }
    }
    
    // MARK: - lazy
    lazy var topFunctionView: AdjustTopFunctionView = {
        let topFunctionView = AdjustTopFunctionView()
        return topFunctionView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    lazy var recoveryBtn: UIButton = {
        let recoveryBtn = UIButton()
        recoveryBtn.setImage(UIImage(named: "icon-contrast-white"), for: UIControl.State.normal)
        recoveryBtn.setImage(UIImage(named: "icon-contrast-white"), for: UIControl.State.highlighted)
        recoveryBtn.addTarget(self, action: #selector(touchDownAction), for: UIControl.Event.touchDown)
        recoveryBtn.addTarget(self, action: #selector(touchUpInsideAction), for: UIControl.Event.touchUpInside)

        return recoveryBtn
    }()
    
    var brightnessFilter:GPUImageBrightnessFilter!
    var picccc:GPUImagePicture!

    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        addView()
        setupLayout()
        callBack()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        addSubview(imageView)
        addSubview(recoveryBtn)
        addSubview(topFunctionView)
    }
    
    // MARK: - action
    @objc func touchDownAction(){
        weak var weakSelf = self
            
        if weakSelf?.topDownActionBlock != nil {
            weakSelf?.topDownActionBlock!()
        }
        
    }
    
    @objc func touchUpInsideAction(){
        weak var weakSelf = self
        if weakSelf?.topUpActionBlock != nil {
            weakSelf?.topUpActionBlock!()
        }
    }
    
    // MARK: - callBack
    func callBack(){
        weak var weakSelf = self
        topFunctionView.returnActionBlock = {
            if weakSelf?.topReturnActionBlock != nil {
                weakSelf?.topReturnActionBlock!()
            }
        }
        
        topFunctionView.saveActionBlock = {
            if weakSelf?.topSaveActionBlock != nil {
                weakSelf?.topSaveActionBlock!()
            }
        }
        
        topFunctionView.lastStepActionBlock = {
            if weakSelf?.topLastStepActionBlock != nil {
                weakSelf?.topLastStepActionBlock!()
            }
        }
        
        topFunctionView.nextStepActionBlock = {
            if weakSelf?.topNextStepActionBlock != nil {
                weakSelf?.topNextStepActionBlock!()
            }
        }
    }
    
    // MARK: - layout
    func setupLayout(){
        
        topFunctionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(20 + 34)
            make.height.equalTo(40)
        }
                
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        
        recoveryBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
