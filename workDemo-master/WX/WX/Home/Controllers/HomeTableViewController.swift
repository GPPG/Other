//
//  HomeTableViewController.swift
//  WX
//
//  Created by 郭鹏 on 2019/10/14.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {

    
   fileprivate let HomeTableViewCellID = "HomeTableViewCellID"

    
    var tableView: UITableView = UITableView.init()
    
    var dataController = HomeTableViewDataController.init()
    
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
        
        addView()
        
        loadData()
        
    }
    
    // MARK: - set up
    
    func setup(){
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCellID)
        tableView.rowHeight = 70
    }
    
    func addView(){
        
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    
    
    func loadData(){
        
         weak var weakSelf = self
        dataController.requestData {
            
            weakSelf?.renderSubjectView()
        }
    }
    
    func renderSubjectView(){
        tableView.reloadData()
        
    }
    
}


extension HomeTableViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.modeArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellID, for: indexPath) as! HomeTableViewCell
        
        let contentMode = dataController.modeArray![indexPath.row]
        
        let viewMode = HomeViewMode.viewModeWithAppearanceMode(mode: contentMode)
        
        cell.bindDataWithViewModel(mode: viewMode)
        
        return cell
    }
    
 
    
}
