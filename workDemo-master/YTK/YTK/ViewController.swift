//
//  ViewController.swift
//  YTK
//
//  Created by 郭鹏 on 2019/10/12.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    var dataController: DataController = DataController()
    
    var firstView: FirstView =  FirstView.loadNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        
        loadData()
    }
    
    func addView(){
        
        firstView.frame = view.frame
        
        firstView.delegate = self
        
        view.addSubview(firstView)
    }
    
    func loadData(){
        
         weak var weakSelf = self
        dataController.requestData {
            
            weakSelf?.renderSubjectView()
        }
    }
    
    
    func renderSubjectView(){
        
        let viewMode = ViewMode.viewModelWithSubjects(modeArray: dataController.modeArray!)
        
        firstView.bindDataWithViewModel(subMode: viewMode)
    }
    
}

extension ViewController: FirstViewProtocol{
    
    func btnAction() {
        print("点击了btn")
    }
    
}

