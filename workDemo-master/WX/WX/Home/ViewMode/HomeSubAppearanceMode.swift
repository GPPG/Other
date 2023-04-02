//
//  HomeSubAppearanceMode.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class HomeSubAppearanceMode: NSObject {

    var nameFont: UIFont = UIFont.systemFont(ofSize: 16)
    
    var messageFont: UIFont = UIFont.systemFont(ofSize: 12)
    
    var nameColor: UIColor = UIColor.black
    
    var messageColor: UIColor = UIColor.lightGray
    
    var nameStr: String?
    
    var messageStr: String?
    
    var iconImage: UIImage?
    
    
    
   static func viewModeForMore(contentMode: HomeContentMode) -> HomeSubAppearanceMode {
        
        let appearanceMode = HomeSubAppearanceMode.init()
        appearanceMode.nameStr = contentMode.nameStr!
        appearanceMode.messageStr = contentMode.messageStr!
        appearanceMode.iconImage = UIImage.init(named: contentMode.iconImageStr!)
        return appearanceMode
    }
}
