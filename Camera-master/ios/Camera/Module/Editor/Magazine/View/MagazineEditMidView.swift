//
//  MagazineEditMidView.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

class MagazineEditMidView: UIView {
    
    // MARK: - lazy
    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView()
        return topImageView
    }()

    lazy var bottomImageView: UIImageView = {
        let bottomImageView = UIImageView()
        return bottomImageView
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
        addSubview(bottomImageView)
        addSubview(topImageView)
    }
    
    // MARK: - layout
    func setupLayout(){
        
        topImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        
        bottomImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }

        
    }
    
}
