//
//  AdjustBottomContainerView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class AdjustBottomContainerView: UIView {

    // MARK: - lazy
    lazy var adjustBottomView: AdjustBottomView = {
        let adjustBottomView = AdjustBottomView()
        adjustBottomView.leftImageStr = "icon-close"
        adjustBottomView.rightImageStr = "icon-yes"
        adjustBottomView.tipLabelStr = "ADJUST"
        return adjustBottomView
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
        addSubview(adjustBottomView)
    }
    
    // MARK: - callBack
    func callBack(){
        adjustBottomView.leftBtnActionBlock = {
            
        }
        
        adjustBottomView.rightBtnActionBlock = {
            
        }
    }
    
    // MARK: - layout
    func setupLayout(){
        adjustBottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
