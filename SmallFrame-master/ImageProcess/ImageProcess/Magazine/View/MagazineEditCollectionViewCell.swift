//
//  MagazineEditCollectionViewCell.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

class MagazineEditCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - lazy
    lazy var magazineView: CropTipBtnView = {
        let magazineView = CropTipBtnView()
        magazineView.tipBtn.isUserInteractionEnabled = false
        magazineView.tipBtn.layer.cornerRadius = 10
        magazineView.tipBtn.layer.masksToBounds = true
        return magazineView
    }()
    
    lazy var maskDarkView: UIView = {
        let maskDarkView = UIView()
        maskDarkView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        maskDarkView.layer.cornerRadius = 10
        maskDarkView.layer.masksToBounds = true
        return maskDarkView
    }()
    
    
    lazy var vipImageView: UIImageView = {
        let vipImageView = UIImageView()
        return vipImageView
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
    
    // MARK: - set
    var titleStr: String?{
        didSet{
            guard let titleStr = titleStr else { return }
            magazineView.tipLabel.text = titleStr
        }
    }
    
    var imageStr: String?{
        didSet{
            guard let imageStr = imageStr else { return }
            magazineView.tipBtn.setImage(UIImage(named: imageStr), for: UIControl.State.normal)
        }
    }
    
    var showImage: UIImage?{
        didSet{
            magazineView.tipBtn.setImage(showImage, for: UIControl.State.normal)
        }
    }
    
    
    var selectStatus: Bool?{
        didSet{
            guard selectStatus != nil else { return }
            
            if selectStatus == true {
                magazineView.tipLabel.font = UIFont.systemFont(ofSize: 13)
//                    UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
                maskDarkView.isHidden = false
            }else{
                magazineView.tipLabel.font = UIFont.systemFont(ofSize: 12)
//                    UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
                maskDarkView.isHidden = true
            }
        }
    }

    

    
    // MARK: - set up
    func addView(){
        contentView.addSubview(magazineView)
        contentView.addSubview(maskDarkView)
        contentView.addSubview(vipImageView)
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
        magazineView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView.snp.edges)
        }
        
        maskDarkView.snp.makeConstraints { (make) in
            make.centerY.equalTo(magazineView).offset(-15)
            make.left.equalTo(magazineView.snp.left).offset(2)
            make.right.equalTo(magazineView.snp.right).offset(-2)
            make.height.equalTo(maskDarkView.snp.width).multipliedBy(1)
        }
        
//        vipImageView.backgroundColor = UIColor.randomColor()
        vipImageView.snp.makeConstraints { (make) in
            make.top.equalTo(maskDarkView.snp.top).offset(-1)
            make.right.equalTo(maskDarkView.snp.right).offset(1)
            make.width.height.equalTo(30)
        }
        
    }

    
    
}
