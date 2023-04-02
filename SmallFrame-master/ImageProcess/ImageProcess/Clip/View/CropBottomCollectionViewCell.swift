//
//  CropBottomCollectionViewCell.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class CropBottomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lazy
    lazy var rotateView: CropTipBtnView = {
        let rotateView = CropTipBtnView()
//        rotateView.tipBtn.backgroundColor = UIColor.randomColor()
//        rotateView.tipLabel.backgroundColor = UIColor.randomColor()
        
        rotateView.tipBtn.setImage(UIImage(named: "icon-adjust"), for: UIControl.State.normal)
        rotateView.tipBtn.isUserInteractionEnabled = false
        rotateView.tipLabel.text = "旋转"
        return rotateView
    }()
    
    // MARK: - set
    var titleStr: String?{
        didSet{
            guard let titleStr = titleStr else { return }
            rotateView.tipLabel.text = titleStr
        }
    }
    
    var imageStr: String?{
        didSet{
            guard let imageStr = imageStr else { return }
            rotateView.tipBtn.setImage(UIImage(named: imageStr), for: UIControl.State.normal)
        }
    }
    
    var bgImageStr: String?{
        didSet{
            guard let bgImageStr = bgImageStr else { return }
            rotateView.tipBtn.setBackgroundImage(UIImage(named: bgImageStr), for: UIControl.State.normal)
        }
    }

    // MARK: - set up
    func addView(){
        self.contentView.addSubview(rotateView)
    }
    
    // MARK: - layout
    func setupLayout(){
        rotateView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView.snp.edges)
        }
    }
}
