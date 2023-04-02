//
//  TwoViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/31.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    var closer: ((String) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if closer != nil{
            closer!("sad")
        }
    }
}
