
//
//  UIDevice-Extension.swift
//  Example
//
//  Created by brian on 2018/4/26.
//  Copyright © 2018年 Brian Inc. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    /// 当前的系统版本获取方式一
    static var modelName0: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 当前的系统版本获取方式二
    static var modelName1: String {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let platform = String(cString: machine)
        return platform
    }
    
    func isX() -> Bool {
        
        if UIScreen.main.bounds.height == 812 || UIScreen.main.bounds.height == 896 {
            
            return true
            
        }
        
        return false
        
    }

    func isiPhonePlus() -> Bool {
        
        if UIScreen.main.bounds.height == 736 {
            
            return true
            
        }
        
        return false
        
    }
    
    func isiPhone5SE() -> Bool {
        
        if UIScreen.main.bounds.height == 568 {
            
            return true
            
        }
        
        return false
        
    }
    
    func isiPhone4S() -> Bool {
        
        if UIScreen.main.bounds.height == 480 {
            
            return true
            
        }
        
        return false
        
    }
    
    func isiPhone6_6s() -> Bool {
        
        if UIScreen.main.bounds.height == 667 {
            
            return true
            
        }
        
        return false
        
    }
    
    func kStatusBarHeight() -> Int {
        
        if self.isX() {
            
            return 44
            
        }
        
        return 20
        
    }
    
    func kStatusBarAndNavBarHeight() -> Int {
        
        if self.isX() {
            
            return 44 + 44
            
        }
        
        return 20 + 44
        
    }

    func kSafeBottomHeight() -> Int {
        
        if self.isX() {
            
            return 34
            
        }
        
        return 0
        
    }


    

}
