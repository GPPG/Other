//
//  MagazineEditViewController.swift
//  Camera
//
//  Created by 郭鹏 on 2019/6/10.
//

import UIKit

typealias SelectMagCompleteBlock = (String) -> Void

class MagazineEditViewController: UIViewController {

    let MagazineEditCollectionViewCellID = "MagazineEditCollectionViewCellID"
    
    var topImageStr: String?
    var bottomImage: UIImage?
    
        
    
    private var imageArray:Array = ["magazine-1-m1-square","magazine-2-w1-square","magazine-3-w2-square","magazine-4-s1-square","magazine-5-s2-square","magazine-6-s3-square","magazine-7-s4-square","magazine-8-f1-square","magazine-9-f2-square","magazine-10-p1-square"]
    
    var titleArray:Array = ["M1","W1","W2","S1","S2","S3","S4","F1","F2","P1"]
    
    private var topImageStrArray:Array = ["magazine-1-m1-cutout","magazine-2-w1-cutout","magazine-3-w2-cutout","magazine-4-s1-cutout","magazine-5-s2-cutout","magazine-6-s3-cutout","magazine-7-s4-cutout","magazine-8-f1-cutout","magazine-9-f2-cutout","magazine-10-p1-cutout"]

    var selectMagCompleteBlock: SelectMagCompleteBlock?
    
    
    fileprivate var slectMagArray: Array<Int> = Array.init()
    fileprivate var currentslectMag: Int?

    
    // MARK: - lazy
    lazy var cellStatusArray: Array = { () -> [Bool] in
        let cellStatusArray =  [false,false,false,false,false,false,false,false,false,false]
        return cellStatusArray
    }()

    lazy var topFunctionView: AdjustTopFunctionView = {
        let topFunctionView = AdjustTopFunctionView()
        topFunctionView.backgroundColor = UIColor.white
        topFunctionView.returnBtn.setImage(UIImage(named: "icon-back"), for: UIControl.State.normal)
        topFunctionView.returnBtn.setImage(UIImage(named: "icon-back"), for: UIControl.State.highlighted)
        topFunctionView.saveBtn.setImage(UIImage(named: "icon-download"), for: UIControl.State.normal)
        topFunctionView.saveBtn.setImage(UIImage(named: "icon-download"), for: UIControl.State.highlighted)
        topFunctionView.nextStepBtn.setImage(UIImage(named: "icon-undo"), for: UIControl.State.normal)
        topFunctionView.nextStepBtn.setImage(UIImage(named: "icon-undo"), for: UIControl.State.highlighted)
        topFunctionView.lastStepBtn.setImage(UIImage(named: "icon-redo"), for: UIControl.State.normal)
        topFunctionView.lastStepBtn.setImage(UIImage(named: "icon-redo"), for: UIControl.State.highlighted)

        return topFunctionView
    }()

    lazy var midView: MagazineEditMidView = {
        let midView = MagazineEditMidView()
        midView.bottomImageView.image = self.bottomImage
        if let imageStr = self.topImageStr{
            midView.topImageView.image = UIImage(named: self.topImageStr!)
        }
        return midView
    }()
    
    lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumLineSpacing = 10
        lt.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.bounces = false
        collectionView.register(MagazineEditCollectionViewCell.self, forCellWithReuseIdentifier: MagazineEditCollectionViewCellID)
        
        return collectionView
    }()
    
    lazy var bottomView: AdjustBottomView = {
        let bottomView = AdjustBottomView()
        bottomView.backgroundColor = UIColor.white
        bottomView.leftBtn.isHidden = true
        bottomView.tipLabel.text = "杂志"
        bottomView.tipLabel.font = UIFont.systemFont(ofSize:17)
        bottomView.rightBtn.setImage(UIImage(named: "icon-yes"), for: UIControl.State.normal)
        bottomView.rightBtn.isHidden = true
        
        return bottomView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        return bgView
    }()

    
    // MARK: - set
    var selectMagzineValue: Int?{
        didSet{
            guard let selectMagzineValue = selectMagzineValue else { return }
            selectValue = selectMagzineValue
            cellStatusArray[selectMagzineValue] = true
        }
    }
    
    private var selectValue: Int?{
        
        didSet{
            if slectMagArray.last != selectValue{
                slectMagArray.append(selectValue!)
            }
        }
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addView()
        setupLayout()
        callBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: IndexPath(item: selectMagzineValue!, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
       

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }
    
    
    // MARK: - set up
    func setupUI(){

        view.backgroundColor = UIColor.init(red: 0.92, green: 0.91, blue: 0.91, alpha: 1)
        
    }

    
    func addView(){
        view.addSubview(bgView)
        view.addSubview(topFunctionView)
        view.addSubview(midView)
        view.addSubview(collectionView)
        view.addSubview(bottomView)

    }
    

    
    // MARK: - callBack
    func callBack(){
        
        weak var weakSelf = self
        topFunctionView.returnActionBlock = {
            weakSelf?.currentslectMag = nil
            weakSelf?.slectMagArray.removeAll()
           weakSelf?.navigationController?.popViewController(animated: true)
        }
        
        topFunctionView.saveActionBlock = {
        

        }
        
        topFunctionView.lastStepActionBlock = {
        }
        
        topFunctionView.nextStepActionBlock = {
        }
        
        bottomView.rightBtnActionBlock = {
            
            let imageStr: String = weakSelf!.topImageStrArray[weakSelf!.selectValue!]
            
            if weakSelf?.selectMagCompleteBlock != nil {
                weakSelf?.selectMagCompleteBlock!(imageStr)
            }
            weakSelf?.navigationController?.popToRootViewController(animated: true)

        }
        
    }
        
    // MARK: - layout
    func setupLayout(){
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(topFunctionView.snp.top)
        }

        topFunctionView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(34 + 20)
        }
        
        midView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(37.5)
            make.right.equalToSuperview().offset(-37.5)
            make.top.equalTo(topFunctionView.snp.bottom).offset(60)
            make.height.equalTo(midView.snp.width).multipliedBy(1.3333)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(0)
            make.height.equalTo(95)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
}



// MARK: - UICollectionViewDataSource
extension MagazineEditViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MagazineEditCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MagazineEditCollectionViewCellID, for: indexPath) as! MagazineEditCollectionViewCell
        cell.titleStr = titleArray[indexPath.row]
        cell.imageStr = imageArray[indexPath.row]
        cell.selectStatus = cellStatusArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height:80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectValue = indexPath.row
        currentslectMag = slectMagArray.count - 1

        didSlectMag(indexPath: indexPath)
    }
    
}

// MARK: - slect Mag
extension MagazineEditViewController{
    
    func didSlectMag(indexPath: IndexPath){
        for (index,_) in cellStatusArray.enumerated() {
            
            if index == indexPath.row{
                cellStatusArray[index] = true
            }else{
                cellStatusArray[index] = false
            }
        }
        
        let str = titleArray[indexPath.row]
        
        
        collectionView.reloadData()
        
        midView.topImageView.image = UIImage(named: topImageStrArray[indexPath.row])
        
        
        collectionView.scrollToItem(at: IndexPath(item: selectValue!, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
    }
    
}


