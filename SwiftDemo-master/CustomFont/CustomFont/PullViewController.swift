
//
//  PullViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/29.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class PullViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "reuseCellForPullToRefresh")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日/HH时mm分ss秒"
        let dateStr = dateFormatter.string(from: dataSource[indexPath.row])
        cell.textLabel?.text = dateStr
        
        return cell
    }
    
    var dataSource = Array<Date>()
    let refresh = UIRefreshControl()
    var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table = UITableView(frame: self.view.frame)
        table.frame.origin.y = 100
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self

        self.addNewElementToArray()
        
        refresh.attributedTitle = NSAttributedString(string: "qwertyuiop")
        refresh.addTarget(self, action: #selector(pullTheRefresh), for: UIControl.Event.valueChanged)
        table.addSubview(refresh)
        table.reloadData()

    }
    

    func addNewElementToArray(){
        
        dataSource.insert(Date(), at: 0)
        
        
    }

    @objc func pullTheRefresh() {
        addNewElementToArray()
        refresh.endRefreshing()
        table.reloadData()
    }

    
}
