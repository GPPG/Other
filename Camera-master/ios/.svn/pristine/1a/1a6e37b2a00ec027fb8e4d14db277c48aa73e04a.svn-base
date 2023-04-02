//
//  Product.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/20.
//

import Foundation

import Foundation
import UIKit

enum Product{
    static let CodeName = isReleaseMode() ? "" :
                                            ""
    static let PublicKey = isReleaseMode() ? "" :
                                             ""
    static let AppId = isReleaseMode() ? "" :
                                         ""
    static let AppsflyerId = isReleaseMode() ? "" :
                                               ""

    static let FacePlusKey = "xiHDatRAJp8ykJLC1pEqSnkBG2am0ptB"
    static let FacePlusSecret = "PDy1pJnvBpk2TsJu3-xSyGe4XxmCDLHX"

    enum Payment {
        static let ShareSecret = isReleaseMode() ? "" :
                                                   ""
        static let useSandbox = isReleaseMode() ? false :
                                                  true
    }

    enum URL{
        static let Appstore = "https://itunes.apple.com/app/id\(AppId)"
        static let AppstoreReview = "itms-apps://itunes.apple.com/app/id\(AppId)?mt=8&action=write-review"
        static let AppSetting = UIApplication.openSettingsURLString
        static let PrivacyPolicy = ""
        static let TermOfService = ""
    }

    static func isReleaseMode() -> Bool{
        let bundle = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        if bundle.lowercased().contains(""){
            return true
        } else{
            return false
        }
    }
}
