//
//  EditorManager.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/23.
//

import Foundation

class EditorManager{
    static func showEditor(parent: UIViewController, photo: OriginPhoto){
        let storyboard = UIStoryboard.init(name: "Editor", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "editor") as! PhotoEditorViewController
        vc.photo = photo
        parent.show(vc, sender: nil)
    }

//    static func showEditor(parent: UIViewController, photo: UIImage){
//        let storyboard = UIStoryboard.init(name: "Editor", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "editor") as! PhotoEditorViewController
//        vc.photo = photo
//        parent.show(vc, sender: nil)
//    }
}
