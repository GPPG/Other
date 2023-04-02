//
//  LeetList.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/7.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LeetList: NSObject {
    
    // 移除链表元素 https://leetcode-cn.com/problems/remove-linked-list-elements/
    static func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil {
            return head
        }
        head?.next = removeElements(head?.next, val)
        return head?.val == val ? head?.next : head
    }
    // 迭代 移除链表元素
    static func removeElements1(_ head: ListNode?, _ val: Int) -> ListNode? {
        let List: ListNode = ListNode()
        List.next = head
        var point: ListNode = List
        
        
        while point.next != nil {
            if point.next?.val == val {
                point.next = point.next?.next
            }else{
                point = point.next!
            }
        }
        
        return List.next
    }
    
    
    // 两数相加 https://leetcode-cn.com/problems/add-two-numbers/
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var tempL1 = l1
        var tempL2 = l2

        
        if tempL1 == nil || tempL2 == nil {
            return nil
        }
        
        
        let dummyHead = ListNode()
        
        var tailHead = dummyHead
        
        
        var carry = 0
        
        while tempL1 != nil || tempL2 != nil {
            
            var v1 = 0
            if tempL1 != nil {
                v1 = tempL1!.val
                tempL1 = tempL1?.next
            }
            
            
            var v2 = 0
            if tempL2 != nil {
                v2 = tempL2!.val
                tempL2 = tempL2?.next
            }
            
            
            
            let sum = v1 + v2 + carry
            
            carry = sum / 10
            
            tailHead.next = ListNode(sum % 10)
            
            tailHead = tailHead.next!
            
        }
        
        if carry != 0 {
            tailHead.next = ListNode(carry)
        }
        
        return dummyHead.next
        
    }

    
    // 相交链表 https://leetcode-cn.com/problems/intersection-of-two-linked-lists/
    static func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        
        if headA == nil || headB == nil {
            return nil
        }
        
        var curA = headA
        
        var curB = headB
        
        while curA !== curB {
            
            curA = (curA == nil) ? headB : curA?.next
            
            curB = (curB == nil) ? headA : curB?.next
        }
        
        return curA
    }
    
    
    // 分隔链表 https://leetcode-cn.com/problems/partition-list/
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        
        if head == nil {
            return nil
        }
        
        var tempHead = head
        
        
        let lhead = ListNode()
        var ltail = lhead
        
        let rhead = ListNode()
        var rtail = rhead
        
        while tempHead != nil {
            
            if tempHead!.val < x {
                ltail.next = tempHead
                ltail = tempHead!
            }else{
                rtail.next = tempHead
                rtail = tempHead!
            }
            
            tempHead = tempHead?.next
        }
        
        // 这句代码不能少
        /*
         * 因为可能出现这样的情况:
         * 原链表倒数第N个节点A的值是>=x的，A后面所有节点的值都是<x的
         * 然后rTail.next最终其实就是A.next
         */
        rtail.next = nil
        
        ltail.next = rhead.next
        
        return lhead.next

    }
    
    
    // 回文链表 https://leetcode-cn.com/problems/palindrome-linked-list/
    func isPalindrome(_ head: ListNode?) -> Bool {
        
        guard let temp = head else {
            return false
        }
        let mid = middleNode(head: temp)
        var lhead = temp
        // 反转链表
        var newR = reverseList(mid.next)
        let oldR = newR
        var res = true
        
        while newR != nil {
            if newR?.val != lhead.val {
                res = false
                break
            }
            newR = newR?.next
            lhead = lhead.next!
        }
        // 反转链表
        reverseList(oldR)
        return res
    }
    
    // 寻找中间节点
    func middleNode(head: ListNode) -> ListNode {
        var slow = head
        var fast = head
        
        while fast.next != nil && fast.next?.next != nil {
            slow = slow.next!
            fast = fast.next!.next!
        }
        return slow
    }
    
    // 删除链表中的节点 https://leetcode-cn.com/problems/delete-node-in-a-linked-list/
    func deleteNode(_ node: ListNode?) {
        
        node?.val = node?.next!.val ?? 1111
        node?.next = node?.next!.next
        
    }
    
    // 反转链表 https://leetcode-cn.com/problems/reverse-linked-list/
    // 迭代法
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil {return nil}
        
        var pre = head
        var cur: ListNode? = nil
        
        while pre != nil {
            let temp = pre?.next
            pre?.next = cur
            cur = pre!
            pre = temp
        }
        return cur
    }
    
    // 递归法
    func reverseList1(_ head: ListNode?) -> ListNode? {
        if head == nil  || head?.next == nil{
            return nil
        }
        
        let temp = head
        
        let p = reverseList1(head?.next)
        temp!.next?.next = temp
        temp?.next = nil
        return p
    }
    
    // 环形链表 https://leetcode-cn.com/problems/linked-list-cycle/
    func hasCycle(_ head: ListNode?) -> Bool {
        
        if head == nil || head?.next == nil {
            return false
        }
        
        var slow = head
        var fast = head?.next
        
        while slow !== fast {
            
            if fast == nil || fast?.next == nil {
                return false
            }
            
            slow = slow?.next
            fast = fast?.next?.next
        }
    
        return true
                
    }
    
    // 合并两个有序链表 https://leetcode-cn.com/problems/merge-two-sorted-lists/
    // 迭代法
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var tempL1 = l1
        var tempL2 = l2
        let dummyHead = ListNode()
        var tailHead = dummyHead
        
        while tempL1 != nil && tempL2 != nil{
            
            if tempL1!.val <= tempL2!.val {
                tailHead.next = tempL1
                tailHead = tempL1!
                tempL1 = tempL1?.next
            }else{
                tailHead.next = tempL2
                tailHead = tempL2!
                tempL2 = tempL2?.next
            }
        }
        if tempL1 == nil {
            tailHead.next = tempL2
        }else{
            tailHead.next = tempL1
        }
        return dummyHead.next
    }
    // 递归法
    func mergeTwoLists1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode?{
        
        guard let tempL1 = l1 else {return l2}
        
        guard let tempL2 = l2 else {return l1}
    
        if tempL1.val <= tempL2.val {
            tempL1.next = mergeTwoLists1(tempL1.next, tempL2)
            return tempL1
        }else{
            tempL2.next = mergeTwoLists1(tempL1, tempL2.next)
            return tempL2
        }
    }
    
    // 合并K个有序链表 https://leetcode-cn.com/problems/merge-k-sorted-lists/
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {

        return nil
    }
    
}
