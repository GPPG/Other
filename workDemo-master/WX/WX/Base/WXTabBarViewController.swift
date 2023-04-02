//
//  WXTabBarViewController.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class WXTabBarViewController: UITabBarController {

    
    var kClassKey = "rootVCClassString"
    
    var kTitleKey = "title"
    
    var kImgKey = "imageName"
    
    var kSelImgKey = "selectedImageName"
    
    var Global_tintColor = UIColor.init(red: 0, green: 190 / 255.0, blue: 12 / 255.0, alpha: 1)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let childItemsArray: [[String : String]] = [
                                [
                                    kClassKey : "HomeTableViewController",
                                    kTitleKey : "微信",
                                    kImgKey    : "tabbar_mainframe",
                                    kSelImgKey : "tabbar_mainframeHL",
                                ],
                                [
                                    kClassKey : "ContactsTableViewController",
                                    kTitleKey : "通讯录",
                                    kImgKey    : "tabbar_contacts",
                                    kSelImgKey : "tabbar_contactsHL",
                                ],
                                [
                                    kClassKey : "DiscoverTableViewController",
                                    kTitleKey : "发现",
                                    kImgKey    : "tabbar_discover",
                                    kSelImgKey : "tabbar_discoverHL",
                                ],
                                [
                                    kClassKey : "MeTableViewController",
                                    kTitleKey : "我",
                                    kImgKey    : "tabbar_me",
                                    kSelImgKey : "tabbar_meHL",
                                ],
                ]
        
        
        for item in childItemsArray {
         
            let aPPName = getAPPName()
            let className:NSString = aPPName + "." + item[kClassKey]! as NSString

            guard let Cls = NSClassFromString(className as String) as? UIViewController.Type  else{
                NSLog("无法转换成ViewController")
                return
            }
            
            let vc:UIViewController = Cls.init()
            
            vc.title = item[kTitleKey]
            
            let nav = WXNavViewController.init(rootViewController: vc)
            
            let tabItem = nav.tabBarItem
            
            tabItem?.title = item[kTitleKey]
            
            tabItem?.image = UIImage.init(named: item[kImgKey]!)
            
            tabItem?.selectedImage = UIImage.init(named: item[kSelImgKey]!)
            
            tabItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Global_tintColor], for: UIControl.State.selected)
            addChild(nav)
            
        }
    }
    
    
    func getAPPName() -> String{
        let nameKey = "CFBundleName"
        let appName = Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
        return appName!
    }
}
