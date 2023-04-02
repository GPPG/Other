//
//  AdjustBottomView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias LeftBtnActionBlock = () -> Void
typealias RightBtnActionBlock = () -> Void


class AdjustBottomView: UIView {
    
    var leftBtnActionBlock: LeftBtnActionBlock?
    var rightBtnActionBlock: RightBtnActionBlock?
    
    
    // MARK: - lazy
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "icon-close"), for: UIControl.State.normal)
        leftBtn.addTarget(self, action: #selector(leftBtnAction), for: UIControl.Event.touchUpInside)
        return leftBtn
    }()
    
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "icon-yes"), for: UIControl.State.normal)
        rightBtn.addTarget(self, action: #selector(rightBtnAction), for: UIControl.Event.touchUpInside)
        return rightBtn
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "调整"
        tipLabel.textColor = UIColor.black
        tipLabel.font = UIFont.systemFont(ofSize: 17)
        tipLabel.textAlignment = NSTextAlignment.center
        return tipLabel
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
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(tipLabel)
    }
    
    // MARK: - set
    var leftImageStr: String?{
        didSet{
            guard let leftImageStr = leftImageStr else { return }
            leftBtn.setImage(UIImage(named: leftImageStr), for: UIControl.State.normal)
        }
    }
    
    var rightImageStr: String?{
        didSet{
            guard let rightImageStr = rightImageStr else { return }
            rightBtn.setImage(UIImage(named: rightImageStr), for: UIControl.State.normal)
        }
    }
    
    var tipLabelStr: String?{
        didSet{
            guard let tipLabelStr = tipLabelStr else { return }
            tipLabel.text = tipLabelStr
        }
    }
    
    
    // MARK: - action
    @objc func leftBtnAction(){
        
        if leftBtnActionBlock != nil{
            leftBtnActionBlock!()
        }
    }
    
    @objc func rightBtnAction(){
        if rightBtnActionBlock != nil {
            rightBtnActionBlock!()
        }
        
    }
    
    
    // MARK: - callBack
    func callBack(){
        
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
        leftBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25.5)
            make.left.equalToSuperview().offset(37.5)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25.5)
            make.right.equalToSuperview().offset(-37.5)
            make.centerY.equalTo(tipLabel.snp.centerY)
        }
        
    }
    
}
