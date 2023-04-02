//
//  FilterToolbarController.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/27.
//

import Foundation
import UIKit

class FilterToolbarController: UIViewController {
    @IBOutlet weak var filterCollection: UICollectionView!

    var delegate: FilterSelectDelegate?
    var dataSource: [LutFilter]?
    var selectedIndex: Int?

    override func viewDidLoad() {
        let navi = navigationController as? CameraToolbarNavigationController
        delegate = navi?.cameraDelegate

        dataSource = FilterDataManager.shared.getSortedLutFilterList()

        filterCollection.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let cellNib = UINib.init(nibName: "FilterCollectionViewCell", bundle: nil)
        filterCollection.register(cellNib, forCellWithReuseIdentifier: "cell")
    }
}

extension FilterToolbarController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 65, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectLutFilter(name: dataSource![indexPath.row].filterName)
        selectedIndex = indexPath.row
        setSelected(indexPath)
    }

    func setSelected(_ indexPath: IndexPath){
        for c in filterCollection.visibleCells{
            (c as! FilterCollectionViewCell).filterLabel.font = UIDefine.FilterNormalFont
        }
        let select = filterCollection.cellForItem(at: indexPath) as! FilterCollectionViewCell
        select.filterLabel.font = UIDefine.FilterFocusFont
    }
}

extension FilterToolbarController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterDataManager.shared.getLutFilterList()!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
        let name = dataSource![indexPath.row].filterName
        cell.filterLabel.text = name

        if indexPath.row == selectedIndex{
            cell.filterLabel.font = UIDefine.FilterFocusFont
        } else{
            cell.filterLabel.font = UIDefine.FilterNormalFont
        }

        cell.filterImageView.image = FilterDataManager.shared.getLutThumbnail(name)
        return cell
    }
}

