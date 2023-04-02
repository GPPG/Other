//
//  ViewMode.swift
//  YTK
//
//  Created by 郭鹏 on 2019/10/12.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class ViewMode: NSObject {
    
    
    var subModeArray: [SubViewMode]?
    
    static func viewModelWithSubjects(modeArray: [Mode]) -> ViewMode{
        
        let subMode = SubViewMode.viewModelForMore(mode: modeArray.first!)
        
        let viewMode = ViewMode.init()
        viewMode.subModeArray = [subMode]
        
        return viewMode
    }
    
    
    
}
