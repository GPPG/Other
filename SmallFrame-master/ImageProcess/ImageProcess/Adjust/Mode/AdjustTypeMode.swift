//
//  AdjustTypeMode.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/14.
//

import UIKit

class AdjustTypeMode: NSObject {
    
    var selectFilterType: SelectFilterType?
    var selectValue: CGFloat
    
    
    init(value: CGFloat,filterType:SelectFilterType) {
        self.selectValue = value
        self.selectFilterType = filterType
        super.init()
    }
}
