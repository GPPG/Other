//
//  LeetStack.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/9.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LeetStack: NSObject {
    
    // 有效的括号 https://leetcode-cn.com/problems/valid-parentheses/
    func isValid(_ s: String) -> Bool {
        
        var stack: [Character] = []
        
        let dict = [")":"(","]":"[","}":"{"]  //做索引
        
        for c in s {
            
            // 左符号
            if dict.values.contains(String(c)) {
                
                stack.append(c)
                // 右括号,且栈里有左括号,并且y左右对称
            }else if stack.count > 0, String( stack.last!) == dict[String(c)] {
                stack.removeLast()
            }else{
                return false
            }
        }
        
        return stack.count == 0 ? true : false

    }
    
    

}
