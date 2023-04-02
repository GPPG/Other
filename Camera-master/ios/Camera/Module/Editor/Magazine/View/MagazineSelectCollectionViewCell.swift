//
//  MagazineSelectCollectionViewCell.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

class MagazineSelectCollectionViewCell: UICollectionViewCell {
    
    // MARK: - lazy
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        self.contentView.addSubview(imageView)
    }
    
    // MARK: - layout
    func setupLayout(){
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
    }
}
