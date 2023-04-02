//
//  ViewController.swift
//  ImageProcess
//
//  Created by 郭鹏 on 2019/12/25.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var cropVC: CropViewController!
    var adjustVC: AdjustViewController!


    // MARK: - Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Set up
    func setupUI(){
        imageView.image = UIImage.init(named: "1")
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Action
    @IBAction func clipAction(_ sender: Any) {
        cropVC = CropViewController()
        cropVC.cropImage = imageView.image
        navigationController?.pushViewController(cropVC, animated: true)
        
        cropVC.cropSucceedBlock = {
            [unowned self] image in
            self.imageView.image = image
        }
    }
    
    
    @IBAction func adjustAction(_ sender: Any) {
        adjustVC = AdjustViewController()
        adjustVC.adjustImage = imageView.image

        navigationController?.pushViewController(adjustVC, animated: true)
        
        adjustVC.disposeCompleteBlock = { [unowned self] disposeImage in
            self.imageView.image = disposeImage
        }

    }
    
    @IBAction func magazineAction(_ sender: Any) {
        var topImageStrArray:Array = ["magazine-1-m1-cutout","magazine-2-w1-cutout","magazine-3-w2-cutout","magazine-4-s1-cutout","magazine-5-s2-cutout","magazine-6-s3-cutout","magazine-7-s4-cutout","magazine-8-f1-cutout","magazine-9-f2-cutout","magazine-10-p1-cutout"]

        let magEdit = MagazineEditViewController()
        magEdit.topImageStr = topImageStrArray[0]
              magEdit.bottomImage = imageView.image
              magEdit.selectMagzineValue = 0
        navigationController?.pushViewController(magEdit, animated: true)

        
    }
    
    
}

