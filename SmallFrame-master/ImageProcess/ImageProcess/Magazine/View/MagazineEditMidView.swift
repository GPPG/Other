//
//  MagazineEditMidView.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

class MagazineEditMidView: UIView {
    
    // MARK: - lazy
    lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 1.5
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
        return scrollView
    }()

    
    
    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView()
        return topImageView
    }()

    lazy var bottomImageView: UIImageView = {
        let bottomImageView = UIImageView()
        bottomImageView.contentMode = .scaleAspectFill
        return bottomImageView
    }()
    
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - set up
    func setupUI(){
        self.layer.masksToBounds = true
    }
    
    func addView(){
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(bottomImageView)
        addSubview(topImageView)
    }
    
    // MARK: - private
    
    func calculateContentSize()-> CGSize {
        
        var W: CGFloat!
        var H: CGFloat!
        
        let imageW = (bottomImageView.image?.size.width)! * 0.5
        let imageH = (bottomImageView.image?.size.height)! * 0.5

        
        if imageW >= imageH {
            W = self.width * 1.5
            H = self.height
        }
        
        if imageW < imageH {
            
            if imageH / imageW == 4.0 / 3.0 {
                W = self.width
                H = self.height
                
            }else{
                W = self.width
                H = self.height * 1.5
            }
        }
        
        return CGSize(width: W, height: H)
        
    }
    
    // MARK: - layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout(){

        let size = calculateContentSize()
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
        
        bottomImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
        }

        
        topImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }

    }
    
    
}


extension MagazineEditMidView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bottomImageView
    }
    
    
    
    
    

}
