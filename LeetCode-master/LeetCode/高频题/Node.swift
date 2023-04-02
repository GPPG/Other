//
//  Node.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/10.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class Node: NSObject {
    
    
    public var key: Int?
    public var value: Int?
    public var prev: Node?
    public var next: Node?
    
    public override init() { self.value = 0; self.key = 0; self.next = nil;self.prev = nil }
    public init(_ key: Int,_ val: Int) { self.value = val; self.key = key;self.next = nil;self.prev = nil}
    public init(_ key: Int,_ val: Int, _ next: Node?) { self.value = val; self.key = key;self.next = next}
}
