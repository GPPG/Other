//
//  CameraToolbarNavigationController.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/27.
//

import Foundation
import UIKit

class CameraToolbarNavigationController: UINavigationController {
    typealias CameraFunctionDelegate = PoseSelectDelegate & FilterSelectDelegate

    var cameraDelegate: CameraFunctionDelegate?

    func jumpPose(){
        popToRootViewController(animated: false)
        topViewController?.performSegue(withIdentifier: "pose", sender: self)

    }

    func jumpFilter(){
        popToRootViewController(animated: false)
        topViewController?.performSegue(withIdentifier: "filter", sender: self)
    }
}
