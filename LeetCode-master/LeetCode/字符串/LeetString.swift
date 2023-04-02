//
//  LeetString.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/9.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LeetString: NSObject {
     
    // 字符串轮转 https://leetcode-cn.com/problems/string-rotation-lcci/
    func isFlipedString(_ s1: String, _ s2: String) -> Bool {
        
        if s1 == "" && s2 == "" { return true }
        let s = s1 + s1
        
        return s.contains(s2) ? true : false
        
    }
    
    
    // 有效的字母异位词 https://leetcode-cn.com/problems/valid-anagram/
    func isAnagram(_ s: String, _ t: String) -> Bool {
        
        if s.count != t.count {
            return false
        }
        
        
        var dic : [String : Int] = [:]
        
        
        for ss in s {
            
            if dic.keys.contains(String(ss)) == true {
                dic[String(ss)] = dic[String(ss)]! + 1
            }else{
                dic[String(ss)] = 1
            }
        }
        
        for tt in t {
               if dic.keys.contains(String(tt)) == true {
                dic[String(tt)] = dic[String(tt)]! - 1
                
                if dic[String(tt)]! < 0 {
                    return false
                }
                
               }else{
                return false
               }
           }
        
        return true
    }

    
    // 翻转字符串里的单词 https://leetcode-cn.com/problems/reverse-words-in-a-string/
    func reverseWords(_ s: String) -> String {
        
        var end = 0
        var array = Array(s+" ")
        //! 前一个字符是否是空格
        var isBank = true
        
        // 1.先剔除多余的空格
        for i in 0..<array.count {
            if array[i] != " " {
                array[end] = array[i]
                end+=1
                isBank = false
            } else { // i是空格,i-1不是空格
                if isBank == false {
                    array[end] = " "
                    end+=1
                    isBank = true
                }
            }
        }
        //! 说明全是空格
        if end == 0 {
            return ""
        }
        //! 因为我们增加了一个空格哨兵，所以 end最终指向的是尾串中一个多余的空格。
        let count = end-1
        
        //! 2. 整体翻转
        reverseArr(&array, 0, count)
        
        //! 3. 局部翻转，遇到空格就将单词翻转，这也是为什么我们翻转函数是左闭右开的原因
        var start = 0
        for i in 0...count {
            if i == count || array[i] == " " {
                reverseArr(&array, start, i)
                start = i+1
            }
        }
        
        let str = String(array[0..<count])
        return str
    }
    
    //！ 左闭右开
    func reverseArr(_ arr:inout [Character], _ left:Int, _ right:Int) {
        var left = left
        var right = right-1
        while left < right {
            arr.swapAt(left, right)
            left+=1
            right-=1
        }
    }
    
    
    // 无重复字符的最长子串 https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/
//    func lengthOfLongestSubstring(_ s: String) -> Int {
//
//
//
//
//    }
    


}
