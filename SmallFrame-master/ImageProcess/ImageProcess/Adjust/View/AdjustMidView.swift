//
//  AdjustMidView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias CallBackBlock = (Int) -> Void

class AdjustMidView: UIView {

    var normalBgImageStr: String?
    var selectBgImageStr: String?
    private var cellStatusDic: Dictionary<String, Bool>?
    
    var callBackBlock: CallBackBlock?


    // MARK: - lazy
    lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 20
        lt.minimumLineSpacing = 20
        lt.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(CropBottomCollectionViewCell.self, forCellWithReuseIdentifier: "CropBottomCollectionViewCellID")
        
        return collectionView
    }()
    
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupLayout()
        callBack()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set
    var titleArray: Array<Any>?{
        didSet{
            setupCellStatus()
            collectionView.reloadData()
        }
    }
    
    var imageArray: Array<Any>?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: - set up
    func addView(){
        addSubview(collectionView)
    }
    
    // MARK: - private
   func setupCellStatus(){
    
    cellStatusDic = Dictionary()
    for (index,item) in titleArray!.enumerated() {
        if index == 0{
            cellStatusDic?.updateValue(true, forKey: item as! String)
            
        }else{
            cellStatusDic?.updateValue(false, forKey: item as! String)
        }
    }
    
    }
    
    // MARK: - public
    func updateDidClickType(row: Int){
        
        let keyStr =  self.titleArray![row] as! NSString
        
        for (key, _) in cellStatusDic! {
            if keyStr.isEqual(to: key){
                cellStatusDic?.updateValue(true, forKey: key)
            }else{
                cellStatusDic?.updateValue(false, forKey: key)
            }
        }
        collectionView.reloadData()
      
        
    }
    
    // MARK: - callBack
    func callBack(){
    }
    
    // MARK: - layout
    func setupLayout(){        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
    }
}

extension AdjustMidView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CropBottomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CropBottomCollectionViewCellID", for: indexPath) as! CropBottomCollectionViewCell
        cell.titleStr = self.titleArray![indexPath.row] as? String
        cell.imageStr = self.imageArray![indexPath.row] as? String
        
        let key =  self.titleArray![indexPath.row] as! String

        let cellStatus = self.cellStatusDic![key]
        
        if cellStatus! {
            cell.bgImageStr = self.selectBgImageStr
        }else{
            cell.bgImageStr = self.normalBgImageStr
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: self.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateDidClickType(row: indexPath.row)
        
        if callBackBlock != nil {
            callBackBlock!(indexPath.row)
        }
    }
}
