//
//  PhotoBrowserViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/30.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class PhotoBrowserViewController: UIViewController {

    var scrollView: UIScrollView!
    
    lazy var imageViews: UIImageView = {
        let imageViews = UIImageView(frame: self.view.bounds)
        imageViews.image = UIImage(named: "phoneBg")
        imageViews.isUserInteractionEnabled = true
        return imageViews
    }()

 
        override func viewDidLoad() {
        super.viewDidLoad()

            
            scrollView = UIScrollView(frame: self.view.bounds)
            scrollView.minimumZoomScale = 0
            scrollView.maximumZoomScale = 4
            scrollView.delegate = self
            scrollView.contentSize = imageViews.bounds.size
            self.view.addSubview(scrollView)
            scrollView.addSubview(imageViews)
    }
    
}

extension PhotoBrowserViewController: UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViews
    }
    
    
    
}
