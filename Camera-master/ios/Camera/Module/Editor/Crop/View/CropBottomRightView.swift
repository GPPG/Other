//
//  CropBottomRightView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias ScaleActionBlock = ((Int)->Void)


class CropBottomRightView: UIView {

    var scaleActionBlock:ScaleActionBlock?
    
    
    // MARK: - lazy
    lazy var titleArray: Array = { () -> [String] in
        let titleArray = ["Free","1:1","3:4","4:3","2:3","3:2","9:16"]
        return titleArray
    }()
    
    lazy var imageArray: Array = { () -> [String] in
        let imageArray = ["icon-size-free","icon-size-square","icon-size-3and4","icon-size-4and3","icon-size-2and3","icon-size-3and2","icon-size-9and16",]
        return imageArray
    }()
    
    lazy var cellStatusArray: Array = { () -> [Bool] in
        let cellStatusArray = [true,false,false,false,false,false,false]
        return cellStatusArray
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 10
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up
    func addView(){
        addSubview(collectionView)
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        
    }
}


// MARK: - UICollectionViewDataSource
extension CropBottomRightView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CropBottomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CropBottomCollectionViewCellID", for: indexPath) as! CropBottomCollectionViewCell
        cell.titleStr = titleArray[indexPath.row]
        
        if cellStatusArray[indexPath.row] {
            cell.imageStr = imageArray[indexPath.row] + "-choose"
        }else{
            cell.imageStr = imageArray[indexPath.row]
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: self.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for (index,_) in cellStatusArray.enumerated() {
            
            if index == indexPath.row{
                cellStatusArray[index] = true
            }else{
                cellStatusArray[index] = false
            }
        }
        collectionView.reloadData()
        
        if scaleActionBlock != nil {
            scaleActionBlock!(indexPath.row)
        }
        
    }
    
    
}
