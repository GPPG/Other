//
//  TextViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/29.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class TextViewController: UIViewController,UITextViewDelegate{

    var limitedTextView: UITextView!
    var allowInputNumberLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.initNavigationBar()
        
        self.initInputField()
        

    }
    

    func initNavigationBar(){
        
        let leftItem = UIBarButtonItem(title: "left", style: UIBarButtonItem.Style.done, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "right", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func initInputField(){
        limitedTextView = UITextView(frame: CGRect(x: 80, y: 200, width: self.view.frame.width - 80, height: 300))
        self.view.addSubview(limitedTextView)
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        
        
        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width - 50, y: self.view.frame.height - 40, width: 50, height: 40))
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.textAlignment = .right
        allowInputNumberLabel.text = "140"
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        let currentCount = textView.text!.count
        
        if currentCount > 140 {
            limitedTextView.resignFirstResponder()
        }
        
        allowInputNumberLabel.text = "\(140 - currentCount)"
    }
    
}
