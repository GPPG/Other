
//
//  StretchyViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/30.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class StretchyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "sdasda")
        cell.textLabel?.text = "111111111"
        return cell
    }
    

    
    var bannerImageView: UIImageView!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height: self.view.bounds.height - 200))
        tableView.rowHeight = 88
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        bannerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        bannerImageView.image = UIImage(named: "phoneBg")
        self.view.addSubview(bannerImageView)

        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        for (index,cell) in cells.enumerated() {
            
            cell.frame.origin.y = 200
            UIView.animate(withDuration: 1, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.frame.origin.y = 0
            }, completion: nil)
        }
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let maxOffsetY = tableView.frame.height
        let validateOffsetY =  -offsetY / maxOffsetY
        let scaleFactor = 1 + validateOffsetY
        bannerImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }
    
    
    
}
