//
//  SwipeaViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/30.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class SwipeaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    var taleView: UITableView!
    
    var array: NSArray!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        array = ["1","2","3","4","5","6","7"]
        
        taleView = UITableView(frame: self.view.bounds)
        taleView.delegate = self
        taleView.dataSource = self
        taleView.rowHeight  = 80
        self.view.addSubview(taleView)
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "asdasd")
        cell.textLabel?.text = array[indexPath.row] as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let likeAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "like") { (action, index) in
            
            print("xihuan")
        }
        return [likeAction]
        
    }
    
    
    
    
    
    
    
    
    
}
