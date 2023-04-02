//
//  ViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/29.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "guoasdoinp asdmapd akdna"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        label.font = UIFont.systemFont(ofSize: 30)
        
        
        let changBtn = UIButton(type: .custom)
        changBtn.setTitle("cahng font", for: UIControl.State.normal)
        changBtn.addTarget(self, action: #selector(changFamily), for: UIControl.Event.touchUpInside)
        changBtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        self.view.addSubview(changBtn)
        changBtn.layer.borderColor = UIColor.blue.cgColor
        changBtn.layer.borderWidth = 1
        changBtn.layer.cornerRadius = 5
        changBtn.snp.makeConstraints { (ma) in
            ma.top.equalTo(500)
            ma.centerX.equalTo(self.view)
            ma.width.equalTo(200)
        }
        

    }

    
    @objc func changFamily(){
        
        label.font = UIFont(name: "Savoye LET", size: 30)
        
    }

}

