//
//  FirstView.swift
//  YTK
//
//  Created by 郭鹏 on 2019/10/12.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

protocol FirstViewProtocol: class{
    
    func btnAction()
    
}


class FirstView: UIView,Nibloadable {

    weak var delegate: FirstViewProtocol?
    
    @IBOutlet weak var oneLabel: UILabel!
    
    @IBOutlet weak var twoLabel: UILabel!
    
    var subModee: ViewMode?
    
    @IBAction func btnAction(_ sender: Any) {
        
        delegate?.btnAction()
    }
    
    func bindDataWithViewModel(subMode: ViewMode){
        subModee = subMode
        
        oneLabel.text = subMode.subModeArray?.first!.oneTitle
        oneLabel.font =  subMode.subModeArray?.first!.oneFont
        oneLabel.textColor =  subMode.subModeArray?.first!.oneColor
        
        twoLabel.text =  subMode.subModeArray?.first!.twoTitle
        twoLabel.font =  subMode.subModeArray?.first!.twoFont
        twoLabel.textColor =  subMode.subModeArray?.first!.twoColor
        
    }
    
    
    
    
    
    
    
}
