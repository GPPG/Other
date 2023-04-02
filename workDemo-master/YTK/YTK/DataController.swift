//
//  DataController.swift
//  YTK
//
//  Created by 郭鹏 on 2019/10/12.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias YTCallBack = () -> Void

class DataController: NSObject {
    
    var modeArray: [Mode]?
    
    var ytCompletionCallback: YTCallBack?
    

    
    func requestData(callback: YTCallBack){
        
        let mode = Mode.init()
        mode.oneName = "张三"
        mode.twoName = "李四"
        modeArray = [mode]
        
        callback()
    }

    
    
    
}
