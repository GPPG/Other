//
//  TumblrViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/31.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit


class TumblrViewController: UIViewController {

    var bgimageView: UIImageView!
    
    var alphaBtn: UIButton!
    var quoteBtn: UIButton!
    var chatBtn: UIButton!
    var photoBtn: UIButton!
    var linkBtn: UIButton!
    var audioBtn: UIButton!
    let dumpingRate:CGFloat = 0.7

    
    var one: OneViewController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bgimageView.image = UIImage(named: "phoneBg")
        self.view.addSubview(bgimageView)
        
        
        one = OneViewController()
        
        



    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
    
    
    

    
}
