//
//  AdjustMidView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class AdjustMidView: UIView {

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
    
    
    // MARK: - set up
    func addView(){
        
    }
    
    // MARK: - callBack
    func callBack(){
        
    }
    
    // MARK: - layout
    func setupLayout(){
        
    }

}


extension AdjustMidView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CropBottomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CropBottomCollectionViewCellID", for: indexPath) as! CropBottomCollectionViewCell
//        cell.titleStr = titleArray[indexPath.row]
//        cell.imageStr = imageArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: self.bounds.height * 0.8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if scaleActionBlock != nil {
            scaleActionBlock!(indexPath.row)
        }
        
        print("点击:\(indexPath.row)")
    }
}
