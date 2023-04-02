
//
//  MyQueue.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/9.
//  Copyright © 2021 郭鹏. All rights reserved.
//

// 用两个栈实现队列 https://leetcode-cn.com/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/

import UIKit

class MyQueue {

    //! 存放要添加的元素 栈
    var addStack:Array<Int>
    //! 存放要移除的元素 栈
    var removeStack:Array<Int>
    
    /** Initialize your data structure here. */
    init() {
      addStack = Array.init()
      removeStack = Array.init()
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
      if !removeStack.isEmpty {
        move(&removeStack, to: &addStack)
      }
      addStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
      if !addStack.isEmpty {
        move(&addStack, to: &removeStack)
      }
      return removeStack.popLast() ?? -1
    }
    
    /** Get the front element. */
    func peek() -> Int {
      if !addStack.isEmpty {
        move(&addStack, to: &removeStack)
      }
      return removeStack.last ?? -1
    }
    
    func empty() -> Bool {
      return addStack.isEmpty && removeStack.isEmpty
    }
  
    //! 将 left 数组 的元素移动到 right 数组中
    func move(_ left: inout [Int], to right: inout [Int]) {
      while !left.isEmpty {
        right.append(left.popLast()!)
      }
    }
}

