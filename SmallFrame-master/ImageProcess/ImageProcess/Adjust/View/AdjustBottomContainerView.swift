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
typealias BottomSilderInsideActionBlock = (Float) -> Void

typealias BottomSelectTypeActionBlock = (Int) -> Void

enum AdjustEnterType: Int {
    case EditType = 0
    case AdjustType = 1
}

class AdjustBottomContainerView: UIView {
    
    
    var bottomLeftActionBlock: BottomLeftActionBlock?
    var bottomRightActionBlock: BottomRightActionBlock?
    var bottomSilderActionBlock: BottomSilderActionBlock?
    var bottomSilderInsideActionBlock: BottomSilderInsideActionBlock?
    var bottomSelectTypeActionBlock: BottomSelectTypeActionBlock?
    
    
    var selectValueArray: Array<CGFloat>?
    var selectIndexRow: Int?
    
    
    
    // MARK: - lazy
    lazy var adjustBottomView: AdjustBottomView = {
        let adjustBottomView = AdjustBottomView()
        adjustBottomView.leftImageStr = "icon-close"
        adjustBottomView.rightImageStr = "icon-yes"
        adjustBottomView.tipLabelStr = "调整"
        return adjustBottomView
    }()
    
    
    
    lazy var midView: AdjustMidView = {
        let midView = AdjustMidView()
        midView.titleArray = ["曝光度", "对比度", "饱和度", "锐化度", "晕影度"]
        midView.imageArray = ["icon-adjust-exposure","icon-adjust-contrast","icon-adjust-saturation","icon-adjust-sharpen","icon-adjust-vignette"]
        midView.normalBgImageStr = "bg-icon-normal"
        midView.selectBgImageStr = "bg-icon-select"
        return midView
    }()
    
    lazy var testLabel: UILabel = {
        let testLabel = UILabel()
        testLabel.isHidden = true
        return testLabel
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor.black;
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
        addSubview(testLabel)
    }
    
    // MARK: - set
    var adjustEnterType:AdjustEnterType?{
        
        didSet{
            if adjustEnterType == AdjustEnterType.EditType{
                slider.addTarget(self, action: #selector(self.sliderValueEditChanged(slider:)), for: UIControl.Event.valueChanged)

                selectValueArray = [CGFloat(ExposureEditFilterNormalValue),CGFloat(ContrastEditFilterNormalValue),CGFloat(SaturationEditFilterNormalValue),CGFloat(SharpenEditFilterNormalValue),CGFloat(VignetteEditFilterNormalValue)]
            }else{
                slider.addTarget(self, action: #selector(self.sliderValueChanged(slider:)), for: UIControl.Event.valueChanged)
                slider.addTarget(self, action: #selector(self.sliderValueUpInside(slider:)), for: UIControl.Event.touchUpInside)

                selectValueArray = [CGFloat(ExposureFilterNormalValue),CGFloat(ContrastFilterNormalValue),CGFloat(SaturationFilterNormalValue),CGFloat(SharpenFilterNormalValue),CGFloat(VignetteFilterNormalValue)]
            }
            
            setSilderValue(indexRow: 0)
        }
        
    }
    
    // MARK: - action
    @objc func sliderValueChanged(slider: UISlider){
        
        selectValueArray![selectIndexRow!] = CGFloat(slider.value)
        
        testLabel.text = String.init(format: "%.2f", slider.value)
        
        let tempSliderValue = slider.value * 100
        
        let bb = Int(tempSliderValue.truncatingRemainder(dividingBy: 3.0))
        
        if bb == 0 || slider.maximumValue == slider.value || slider.minimumValue == slider.value  {
            if self.bottomSilderActionBlock != nil {
                self.bottomSilderActionBlock!(slider.value)
            }
        }
    }
    
    @objc func sliderValueUpInside(slider: UISlider){
        
        
        let tempSliderValue = slider.value * 100
        
        let bb = Int(tempSliderValue.truncatingRemainder(dividingBy: 3.0))
        
        if bb == 0 || slider.maximumValue == slider.value || slider.minimumValue == slider.value  {
            if self.bottomSilderInsideActionBlock != nil {
                self.bottomSilderInsideActionBlock!(slider.value)
            }
        }
        
    }

    
    @objc func sliderValueEditChanged(slider: UISlider){
        
        selectValueArray![selectIndexRow!] = CGFloat(slider.value)
        
        testLabel.text = String.init(format: "%.2f", slider.value)
        
        if self.bottomSilderActionBlock != nil {
            self.bottomSilderActionBlock!(slider.value)
        }
    }

    // MARK: - callBack
    func callBack(){
        
        // 设置初始状态
        if bottomSelectTypeActionBlock != nil {
            bottomSelectTypeActionBlock!(0)
        }
        
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
            
            weakSelf?.setSilderValue(indexRow: indexRow)
            if weakSelf?.bottomSelectTypeActionBlock != nil {
                weakSelf?.bottomSelectTypeActionBlock!(indexRow)
            }
        }
    }
    
    // MARK: - public
    func updateTypeUI(mode: AdjustTypeMode){
        
        setSilderValue(indexRow: mode.selectFilterType!.rawValue)
        midView.updateDidClickType(row: mode.selectFilterType!.rawValue)
        
        
    }
    
    // MARK: - private
    func setSilderValue(indexRow: Int){
        
        selectIndexRow = indexRow

        
        if adjustEnterType == AdjustEnterType.EditType {
            slider.maximumValue = 1
            slider.minimumValue = 0
            slider.value = Float(selectValueArray![indexRow])
            testLabel.text = String.init(format: "%.2f", slider.value)
            return
        }
        
        switch indexRow {
        // exposure
        case 0:
            slider.maximumValue = ExposureFilterMaxValue
            slider.minimumValue = ExposureFilterMinValue
            
        // Contrast
        case 1:
            slider.maximumValue = ContrastFilterMaxValue
            slider.minimumValue = ContrastFilterMinValue
            
        // Saturation
        case 2:
            slider.maximumValue = SaturationFilterMaxValue
            slider.minimumValue = SaturationFilterMinValue
            
        // sharpen
        case 3:
            slider.maximumValue = SharpenFilterMaxValue
            slider.minimumValue = SharpenFilterMinValue
            
        // vignette
        case 4:
            slider.maximumValue = VignetteFilterMaxValue
            slider.minimumValue = VignetteFilterMinValue
        default:
            slider.maximumValue = 1
            slider.minimumValue = 0
            slider.value = 0
        }
        slider.value = Float(selectValueArray![indexRow])
        testLabel.text = String.init(format: "%.2f", slider.value)
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
        
        testLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(slider.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
    }
}
