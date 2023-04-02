//
//  CropTipBtnView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias TipBtnActionBlock = ()->Void


class CropTipBtnView: UIView {
    
    var tipBtnActionBlock: TipBtnActionBlock?

    // MARK: - lazy
    lazy var tipBtn: UIButton = {
        let tipBtn = UIButton()
        tipBtn.addTarget(self, action: #selector(tipAction), for: UIControl.Event.touchUpInside)
        return tipBtn
    }()
    
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = UIColor.black
        tipLabel.font = UIFont.systemFont(ofSize: 13)
        tipLabel.textAlignment = NSTextAlignment.center
        return tipLabel
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        self.addSubview(tipBtn)
        self.addSubview(tipLabel)
        
    }
    
    
    // MARK: - action
    @objc func tipAction(){
        
        if tipBtnActionBlock != nil {
            tipBtnActionBlock!()
        }
    }
    
    
    // MARK: - layout
    func setupLayout(){
        
        tipBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-15)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalTo(self).offset(15)
        }
    }
}
