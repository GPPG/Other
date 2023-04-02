//
//  LRUCache.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/10.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LRUCache {

    var dummyHead : Node = Node()
    var tailHead : Node =  Node()
    
    var dicCache: [Int : Node] = [:]
    
    
    var capacity : Int?

    
    init(_ capacity: Int) {
        
        self.capacity = capacity
        self.dummyHead.next = self.tailHead
        self.tailHead.prev = self.dummyHead
        
    }
    
    func get(_ key: Int) -> Int {
        
        guard let tempNode = dicCache[key]  else {
            return -1
        }
        
        removeNode(node: tempNode)
        addAfterFirstNode(node: tempNode)
        
        return tempNode.value ?? 0
    }
    
    func put(_ key: Int, _ value: Int) {
        
    
        
        var tempNode = dicCache[key]
        
        if tempNode != nil {
            tempNode!.value = value
            removeNode(node: tempNode!)
        }else{
            
//            if dicCache.count == capacity {
//                removeNode(node: tailHead.prev!)
//                dicCache.removeValue(forKey: tailHead.prev!.key!)
//            }
            
            tempNode = Node(key, value)
            dicCache[key] = tempNode
        }
        addAfterFirstNode(node: tempNode!)
        
//     if dicCache.count == 1 {
//
//        tailHead = tempNode!
//
//        }

    }
    
    
    func removeNode(node: Node){
        
//        if node.key == tailHead.key {
//            tailHead = node.prev!
//        }
//
        node.next?.prev = node.prev
        node.prev?.next = node.next
        
        
    }
    
    func addAfterFirstNode(node: Node){
        
        node.next = dummyHead.next
        dummyHead.next?.prev = node
        
        dummyHead.next = node
        node.prev = dummyHead
    }
}
