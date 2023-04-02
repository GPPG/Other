//
//  ListNode.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/7.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class ListNode: NSObject {
    public var val: Int
    public var next: ListNode?
    public override init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
}
