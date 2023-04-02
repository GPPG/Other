//
//  SubViewMode.swift
//  YTK
//
//  Created by 郭鹏 on 2019/10/12.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class SubViewMode: NSObject {

    var oneTitle: String?
    
    var twoTitle: String?
    
    var oneFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var twoFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var oneColor: UIColor = UIColor.blue
    
    var twoColor: UIColor = UIColor.red
    
    
    
   static func viewModelForMore() -> SubViewMode {
        
        return SubViewMode.init()
    }
    
    
   static func viewModelForMore(mode: Mode) -> SubViewMode {
        
        let subMode = SubViewMode.init()
        subMode.oneTitle = "\(mode.oneName ?? "XX")吃苹果"
        subMode.twoTitle = "\(mode.twoName ?? "XX")吃西瓜"
        
        return subMode
    }
    
    
    
    
    
}
