//
//  HomeViewMode.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class HomeViewMode: NSObject {

    var subAppearanceMode: HomeSubAppearanceMode?
    
    
    
    
       static func viewModeWithAppearanceMode(mode: HomeContentMode) -> HomeViewMode {
    
        let viewMode = HomeViewMode.init()
        
        
        let appMode = HomeSubAppearanceMode.viewModeForMore(contentMode: mode)

        
        viewMode.subAppearanceMode = appMode
        
        return viewMode
    
    }
    
    
    
    
    
    
    
}
