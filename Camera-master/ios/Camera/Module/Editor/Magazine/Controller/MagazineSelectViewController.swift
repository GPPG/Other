//
//  MagazineSelectViewController.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/9.
//

import UIKit

class MagazineSelectViewController: UIViewController {
    
    
    // MARK: - lazy
    lazy var navView: MagzineSelectNavVIew = {
        let navView = MagzineSelectNavVIew()
        return navView
    }()
    
    let configuration = PhotoPickerConfiguration()

    
    
    lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumLineSpacing = 10
        lt.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.bounces = false
        collectionView.register(MagazineSelectCollectionViewCell.self, forCellWithReuseIdentifier: "MagazineSelectCollectionViewCellID")
        
        return collectionView
    }()
    
    lazy var imageArray: Array = { () -> [Any] in
        let imageArray = ["magazine-1-m1","magazine-2-w1","magazine-3-w2","magazine-4-s1","magazine-5-s2","magazine-6-s3","magazine-7-s4","magazine-8-f1","magazine-9-f2","magazine-10-p1"]
        return imageArray
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - set up
    func setupUI(){
        
    }
    
    func addView(){
        self.view.addSubview(collectionView)
        self.view.addSubview(navView)
    }
    
    // MARK: - callBack
    func callBack(){
        
        navView.returnActionBlock = {
         
            
        }
        
    }
    
    // MARK: - action
    func selectImage(){
        
        let controller = PhotoPickerViewController()
        controller.delegate = self
        controller.configuration = configuration
        controller.modalPresentationStyle = .overCurrentContext
        
        configuration.maxSelectCount = 1
        configuration.countable = false
        navigationController?.pushViewController(controller, animated: true)
        
//        present(controller, animated: true, completion: nil)
        
    }
    
    // MARK: - layout
    func setupLayout(){

        navView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIDevice().kSafeBottomHeight() + 10)
            make.height.equalTo(88)
            make.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(navView.snp.bottom).offset(0)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MagazineSelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MagazineSelectCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagazineSelectCollectionViewCellID", for: indexPath) as! MagazineSelectCollectionViewCell
        cell.imageView.image = UIImage(named: imageArray[indexPath.row] as! String)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width * 0.42, height:self.view.bounds.width * 0.42 * 4.0 / 3.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectImage()
    }
        
}

// MARK: - PhotoPickerDelegate
extension MagazineSelectViewController: PhotoPickerDelegate {
    
    func photoPickerDidCancel(_ photoPicker: PhotoPickerViewController) {
//        photoPicker.dismiss(animated: true, completion: nil)
        photoPicker.navigationController?.popViewController(animated: true)
    }
    
    // 点击确定按钮
    func photoPickerDidSubmit(_ photoPicker: PhotoPickerViewController, assetList: [PickedAsset]) {
//        photoPicker.dismiss(animated: true, completion: nil)
        
        let image = UIImage(contentsOfFile: assetList[0].path)
        
        let magazineEdit = MagazineEditViewController()
        magazineEdit.topImageStr = "magazine-1-m1-cutout"
        magazineEdit.bottomImage = image
        magazineEdit.selectMagzineValue = 0

        navigationController?.pushViewController(magazineEdit, animated: true)
        
        print(assetList[0].path)
    }
    
    func photoPickerDidPermissionsNotGranted(_ photoPicker: PhotoPickerViewController) { }
    
    func photoPickerDidPermissionsGranted(_ photoPicker: PhotoPickerViewController) { }
    
    func photoPickerDidPermissionsDenied(_ photoPicker: PhotoPickerViewController) { }
    
}
