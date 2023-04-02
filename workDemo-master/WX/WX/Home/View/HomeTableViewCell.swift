//
//  HomeTableViewCell.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import SnapKit


class HomeTableViewCell: UITableViewCell {
    
    // MARK: - lazy
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        return messageLabel
    }()
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setupLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        
//        messageLabel.backgroundColor = UIColor.red
//        
//        nameLabel.backgroundColor = UIColor.blue
//        
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
    }
    
    // MARK: - public
    func bindDataWithViewModel(mode: HomeViewMode){
     
        iconImageView.image = mode.subAppearanceMode?.iconImage
        
        nameLabel.text = mode.subAppearanceMode?.nameStr
        
        messageLabel.text = mode.subAppearanceMode?.messageStr
        
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(26)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalToSuperview().offset(-13)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(18)
        }
        
    }
    

    
    
    
    

}
