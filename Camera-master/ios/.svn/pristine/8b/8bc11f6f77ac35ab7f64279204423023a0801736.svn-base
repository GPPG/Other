//
//  PoseToolbarController.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/27.
//

import Foundation
import UIKit

class PoseToolbarController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var tabButtonGroup: [PoseTabButton]!

    var delegate: PoseSelectDelegate?

    var selectedCatalogy: PoseCatalogy = .Girl

    override func viewDidLoad() {
        let navi = navigationController as? CameraToolbarNavigationController
        delegate = navi?.cameraDelegate
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let nib = UINib(nibName: "PoseCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }

    @IBAction func changePoseCatelogy(_ sender: PoseTabButton) {
        switch sender.tag{
        case 0: selectedCatalogy = .Girl
        case 1: selectedCatalogy = .Boy
        case 2: selectedCatalogy = .Couple
        case 3: selectedCatalogy = .Party
        default:break
        }
        for tab in tabButtonGroup{
            tab.inSelected = false
            tab.setNeedsDisplay()
            tab.layoutSubviews()
        }
        sender.inSelected = true
        sender.setNeedsDisplay()
        sender.layoutSubviews()
        collectionView.reloadData()
    }

}

extension PoseToolbarController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 57, height: 57)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedPose(catalogy: selectedCatalogy, index: indexPath.row)
    }
}

extension PoseToolbarController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PoseDataManager.shared.getPoseCount(catalogy: selectedCatalogy)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PoseCollectionViewCell
        let thumbnail = PoseDataManager.shared.getPoseThumbnail(catalogy: selectedCatalogy, index: indexPath.row)
        cell.image.image = thumbnail
        return cell
    }
}

