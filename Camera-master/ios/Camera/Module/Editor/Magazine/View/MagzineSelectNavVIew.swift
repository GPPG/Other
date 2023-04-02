//
//  MagzineSelectNavVIew.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

typealias MagReturnActionBlock = () -> Void

class MagzineSelectNavVIew: UIView {
    
    var returnActionBlock:MagReturnActionBlock?

    // MARK: - lazy
    lazy var returnBtn: UIButton = {
        let returnBtn = UIButton()
        returnBtn.setImage(UIImage(named: "icon-back"), for: UIControl.State.normal)
        returnBtn.setImage(UIImage(named: "icon-back"), for: UIControl.State.highlighted)
        returnBtn.addTarget(self, action: #selector(returnBtnAction), for: UIControl.Event.touchUpInside)
        return returnBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "MAGAZINE COVER"
        return titleLabel
    }()
    
    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.gray
//            UIColor.init(red: 118, green: 118, blue: 118, alpha: 1)
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.textAlignment = NSTextAlignment.center
        subTitleLabel.text = "1/2 Selct a design"
        return subTitleLabel
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(returnBtn)
    }

    // MARK: - action
    @objc func returnBtnAction(){
        if returnActionBlock != nil {
            returnActionBlock!()
        }

    }

    
    // MARK: - layout
    func setupLayout(){
        returnBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(22)
            make.width.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(returnBtn)
            make.left.right.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
        
    }
    
    
}
