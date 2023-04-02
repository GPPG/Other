//
//  AdjustTopFunctionView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/6.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias ReturnActionBlock = () -> Void
typealias SaveActionBlock = () -> Void
typealias LastStepActionBlock = () -> Void
typealias NextStepActionBlock = () -> Void


class AdjustTopFunctionView: UIView {
    
    var returnActionBlock:ReturnActionBlock?
    var saveActionBlock:SaveActionBlock?
    var lastStepActionBlock:LastStepActionBlock?
    var nextStepActionBlock:NextStepActionBlock?


    // MARK: - lazy
    lazy var returnBtn: UIButton = {
        let returnBtn = UIButton()
        returnBtn.setImage(UIImage(named: "icon-back-white"), for: UIControl.State.normal)
        returnBtn.setImage(UIImage(named: "icon-back-white"), for: UIControl.State.highlighted)
        returnBtn.addTarget(self, action: #selector(returnBtnAction), for: UIControl.Event.touchUpInside)
        return returnBtn
    }()
    
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton()
        saveBtn.setImage(UIImage(named: "icon-download-white"), for: UIControl.State.normal)
        saveBtn.setImage(UIImage(named: "icon-download-white"), for: UIControl.State.highlighted)
        saveBtn.addTarget(self, action: #selector(saveBtnAction), for: UIControl.Event.touchUpInside)
        return saveBtn
    }()
    
    lazy var lastStepBtn: UIButton = {
        let lastStepBtn = UIButton()
        lastStepBtn.setImage(UIImage(named: "icon-redo-white"), for: UIControl.State.normal)
        lastStepBtn.setImage(UIImage(named: "icon-redo-white"), for: UIControl.State.highlighted)
        lastStepBtn.addTarget(self, action: #selector(nextStepBtnAction), for: UIControl.Event.touchUpInside)
        lastStepBtn.isHidden = true
        return lastStepBtn
    }()
    
    lazy var nextStepBtn: UIButton = {
        let nextStepBtn = UIButton()
        nextStepBtn.setImage(UIImage(named: "icon-undo-white"), for: UIControl.State.normal)
        nextStepBtn.setImage(UIImage(named: "icon-undo-white"), for: UIControl.State.highlighted)
        nextStepBtn.addTarget(self, action: #selector(lastStepBtnAction), for: UIControl.Event.touchUpInside)
        nextStepBtn.isHidden = true
        return nextStepBtn
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addView()
        setupLayout()
        callBack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func setupUI(){
        self.backgroundColor = UIColor.clear
    }
    
    
    func addView(){
        addSubview(returnBtn)
        addSubview(saveBtn)
        addSubview(lastStepBtn)
        addSubview(nextStepBtn)
    }
    
    // MARK: - action
    @objc func returnBtnAction(){
        
        if returnActionBlock != nil {
            returnActionBlock!()
        }
    }
    @objc func saveBtnAction(){
        if saveActionBlock != nil {
            saveActionBlock!()
        }
    }
    @objc func lastStepBtnAction(){
        if lastStepActionBlock != nil {
            lastStepActionBlock!()
        }
        
        
    }
    @objc func nextStepBtnAction(){
        if nextStepActionBlock != nil {
            nextStepActionBlock!()
        }
    }

    
    // MARK: - callBack
    func callBack(){
        
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
        returnBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        lastStepBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(30)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-30)
        }
    }
    
}
