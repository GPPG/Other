//
//  WatchViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/29.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController {

    var resultLabel: UILabel!
    var timer: Timer!
    var lableNmuber: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let startView = UIView()
        startView.backgroundColor = UIColor.green
        self.view.addSubview(startView)
        
        startView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view.frame.width * 0.5)
            make.top.equalTo(self.view).offset(300)
        }
        
        
        let startBtn = UIButton()
        startBtn.setTitle("start", for: UIControl.State.normal)
        startBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        startBtn.addTarget(self, action: #selector(startAction), for: UIControl.Event.touchUpInside)
        startView.addSubview(startBtn)
        
        startBtn.snp.makeConstraints { (make) in
            make.center.equalTo(startView)
            
        }
        
        
        
        
        
        resultLabel = UILabel()
        resultLabel.text = "0"
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.textColor = UIColor.black
        self.view.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(40)
            make.centerX.equalTo(self.view)
        }
        
      
        
    }
    
    @objc func startAction(){
        
        if self.timer != nil {
            
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
          self.lableNmuber = self.lableNmuber + 0.1
            self.resultLabel.text = String((self.lableNmuber))
            
        })
        
        
    }


}
