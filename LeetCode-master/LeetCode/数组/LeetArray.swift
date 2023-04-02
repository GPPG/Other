//
//  LeetArray.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/6.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LeetArray: NSObject {
    
    // 合并两个有序数组 https://leetcode-cn.com/problems/merge-sorted-array/
    static func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var i1 = m - 1
        var i2 = n - 1
        var cur = nums1.count - 1
        
        while i2 >= 0 {
            
            if i1 >= 0 && nums1[i1] > nums2[i2] {
                
                nums1[cur] = nums1[i1]
                cur = cur - 1
                i1 = i1 - 1
            }else{
                nums1[cur] = nums2[i2]
                cur = cur - 1
                i2 = i2 - 1
            }
        }
        
    }
        
    // 颜色分类 https://leetcode-cn.com/problems/sort-colors/
    static  func sortColors(_ nums: inout [Int]) {
        
        var cur = 0
        var p0 = 0
        var p2 = nums.count - 1
        
        while cur <= p2 {
            
            if nums[cur] == 0 {
                Array<Any>.exchangeValue(&nums, p0, cur)
                cur = cur + 1
                p0 = p0 + 1
            }else if nums[cur] == 1{
                cur = cur + 1
            }else{
                Array<Any>.exchangeValue(&nums, cur, p2)
                p2 = p2 - 1
            }
        }
    }
    
    // 部分排序 https://leetcode-cn.com/problems/sub-sort-lcci/
    static func subSort(_ array: [Int]) -> [Int] {
        
        if array.count == 0 {
            return [-1,1]
        }
        
        var max = array.first!
        var r = -1
        
        for (index,value) in array.enumerated() {
            
            if value >= max {
                max = value
            }else{
                r = index
            }
        }
        if (r == -1) {return [-1,1]}
        
        var min = array.last!
        var l = -1
        for (index,value) in array.enumerated().reversed() {
            if value <= min {
                min = value
            }else{
                l = index
            }
        }
        return [l,r]
    }
    
    // 有序数组的平方 https://leetcode-cn.com/problems/squares-of-a-sorted-array/
    static func sortedSquares(_ nums: [Int]) -> [Int] {
        
        var array = [Int]()
        
        var l = 0
        
        var r = nums.count - 1
                
        for _ in nums {
            
            let lvlaue = nums[l] * nums[l]
            let rvlaue = nums[r] * nums[r]
            
            if rvlaue > lvlaue {
                array.append(rvlaue)
                r = r - 1
            }else{
                array.append(lvlaue)
                l = l + 1
            }
            
            if r < l {
                break
            }
        }
        return array.reversed()
    }
}

extension Array{

    
    // 交换数组两个索引的位置
    static func exchangeValue<T>(_ nums: inout [T], _ a: Int, _ b: Int) {
        (nums[a], nums[b]) = (nums[b], nums[a])
    }
    

    
}

