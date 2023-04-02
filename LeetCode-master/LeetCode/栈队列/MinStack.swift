//
//  MinStack.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/9.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class MinStack {
    var stack: [(Int,Int)] = []
    init() {
        stack.reserveCapacity(500)
    }
    
    func push(_ val: Int) {
        if let minValue = stack.last?.1 {
            stack.append((val,min(minValue, val)))
        }else{
            stack.append((val,val))
        }
    }
    func pop() {
        stack.removeLast()
    }
    func top() -> Int {
        return stack.last?.0 ?? 0
    }
    func getMin() -> Int {
        
        return stack.last!.1
        
    }
    
}
