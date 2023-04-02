//
//  AdjustBottomContainerView.swift
//  cmmm
//
//  Created by 郭鹏 on 2019/6/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

typealias BottomLeftActionBlock = () -> Void
typealias BottomRightActionBlock = () -> Void
typealias BottomSilderActionBlock = (Float) -> Void
typealias BottomSelectTypeActionBlock = (Int) -> Void


class AdjustBottomContainerView: UIView {
    
    var bottomLeftActionBlock: BottomLeftActionBlock?
    var bottomRightActionBlock: BottomRightActionBlock?
    var bottomSilderActionBlock: BottomSilderActionBlock?
    var bottomSelectTypeActionBlock: BottomSelectTypeActionBlock?

    
    var selectValue: Array = [0,1,1,0,0.75]
    var selectIndexRow: Int?
    
    
    
    // MARK: - lazy
    lazy var adjustBottomView: AdjustBottomView = {
        let adjustBottomView = AdjustBottomView()
        adjustBottomView.leftImageStr = "icon-close"
        adjustBottomView.rightImageStr = "icon-yes"
        adjustBottomView.tipLabelStr = "ADJUST"
        return adjustBottomView
    }()
    
    lazy var midView: AdjustMidView = {
        let midView = AdjustMidView()
        midView.titleArray = ["Exposure","Contrast","Saturation","Sharpen","Vignette"]
        midView.imageArray = ["icon-adjust-exposure","icon-adjust-contrast","icon-adjust-saturation","icon-adjust-sharpen","icon-adjust-vignette"]
        midView.normalBgImageStr = "bg-icon-normal"
        midView.selectBgImageStr = "bg-icon-select"
        return midView
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor.black;
        slider.addTarget(self, action: #selector(self.sliderValueChanged(slider:)), for: UIControl.Event.touchUpInside)
        return slider
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
        addSubview(adjustBottomView)
        addSubview(midView)
        addSubview(slider)
    }
    
    // MARK: - action
    @objc func sliderValueChanged(slider: UISlider){
        print("\(slider.value)")
        
        selectValue[selectIndexRow!] = Double(slider.value)
        
        if self.bottomSilderActionBlock != nil {
            self.bottomSilderActionBlock!(slider.value)
        }
    }
    
    // MARK: - callBack
    func callBack(){
        weak var weakSelf = self
        adjustBottomView.leftBtnActionBlock = {
            
            if weakSelf?.bottomLeftActionBlock != nil {
                weakSelf?.bottomLeftActionBlock!()
            }
            
        }
        
        adjustBottomView.rightBtnActionBlock = {
            if weakSelf?.bottomRightActionBlock != nil {
                weakSelf?.bottomRightActionBlock!()
            }
            
        }
        
        midView.callBackBlock = { (indexRow) in
            print("行数:\(indexRow)")
            
            weakSelf?.setSilderValue(indexRow: indexRow)
            
            if weakSelf?.bottomSelectTypeActionBlock != nil {
                weakSelf?.bottomSelectTypeActionBlock!(indexRow)
            }
        }
    }
    
    // MARK: - private
    func setSilderValue(indexRow: Int){

        selectIndexRow = indexRow
        switch indexRow {
            // exposure
        case 0:
            slider.maximumValue = 10
            slider.minimumValue = -10
            
            // Contrast
        case 1:
            slider.maximumValue = 4
            slider.minimumValue = 0
            
            // Saturation
        case 2:
            slider.maximumValue = 2
            slider.minimumValue = 0
            
            // sharpen
        case 3:
            slider.maximumValue = 4
            slider.minimumValue = 0

            // vignette
        case 4:
            slider.maximumValue = 1
            slider.minimumValue = 0
        default:
            slider.maximumValue = 10
            slider.minimumValue = -10
            slider.value = 0
        }
        slider.value = Float(selectValue[indexRow])
    }
    
    
    // MARK: - layout
    func setupLayout(){
        
        adjustBottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        midView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview()
            make.bottom.equalTo(adjustBottomView.snp_topMargin).offset(0)
            make.height.equalTo(95)
        }
        
        slider.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(22.5)
            make.bottom.equalTo(midView.snp.top).offset(-10)
        }
        
    }
}
