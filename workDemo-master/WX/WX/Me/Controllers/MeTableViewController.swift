//
//  MeTableViewController.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class MeTableViewController: UIViewController {

    
    var infoView: MeView = MeView.loadNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
    }
    
    
    func addView(){
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(88)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let sb = UIStoryboard(name: "InfoViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InfoViewControllerID") as! InfoViewController
        
//        vc.iconImageView.image = infoView.iconIMageView.image
        self.navigationController!.pushViewController(vc, animated: true)

        
        
        
        
    }
    
    
    
    
    
    


}
