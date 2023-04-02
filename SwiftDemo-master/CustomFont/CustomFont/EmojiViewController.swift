//
//  EmojiViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/30.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    

    var slotMachine: UIPickerView!
    var emojiArray = ["😀","😎","😈","👻","🙈","🐶","🌚","🍎","🎾","🐥","🐔"]
    var resultLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slotMachine = UIPickerView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 350))
        slotMachine.dataSource = self
        slotMachine.delegate = self
        self.view.addSubview(slotMachine)
        
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 0, animated: false)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 1, animated: false)
        slotMachine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 2, animated: false)

        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 99
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let textLabel = UILabel()
        
        textLabel.text = emojiArray[row]
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 66)
        return textLabel
    }
}
