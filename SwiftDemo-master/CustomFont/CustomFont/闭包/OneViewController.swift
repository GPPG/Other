//
//  OneViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/31.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    var two: TwoViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        combine(handle: { (test, tes1) -> (Void) in
        print(tes1+test)
        }, num: 2)
        
        
        
        
        two = TwoViewController()
        two.view.backgroundColor = UIColor.red
        
        two.closer = {
            print($0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(two, animated: true, completion: nil)

    }
    
    typealias Number = (_ num3: Int) -> (Int)
    
    func make(num: Number){
        
    }
    
    
    
    func combine(handle: (String,String) -> (Void),num: Int) {
        handle("hello","dasd")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
