//
//  LeetCode.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/9.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class LeetCode: NSObject {

    
    // 移动零 https://leetcode-cn.com/problems/move-zeroes/
    func moveZeroes(_ nums: inout [Int]) {
        
        var left = 0, cur = 0
        let count = nums.count
                
        while cur < count {
            
            if nums[cur] != 0 {
                Array<Any>.exchangeValue(&nums, cur, left)
                left = left + 1
            }
            
            cur = cur + 1
        }
    }
    
    // 两数之和 https://leetcode-cn.com/problems/two-sum/
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var dic: [Int : Int] = Dictionary()
        
        for (index,value) in nums.enumerated() {
            
            if dic.keys.contains(target - value) {
                return [dic[target - value]!,index]
            }else{
                dic[value] = index
            }
        }
        return []
    }
    
    // 三数之和 https://leetcode-cn.com/problems/3sum/
    static func threeSum(_ nums: [Int]) -> [[Int]] {
            
        var res: [[Int]] = Array()
        // 数组数量小于3,结束
        if nums.count < 3{return []}
        // 排序
        let sortNums = nums.sorted()
        // 一重循环的右边界
        let lastRang = sortNums.count - 3
        // 二重循环的右指针
        let lastR = sortNums.count - 1
        
        for i in 0...lastRang {
            // 去重
            if i > 0 && sortNums[i] == sortNums[i - 1] {continue}
            // 二重循环的左指针
            var l = i + 1
            // 用来做 a + b + c = 0
            let remain = -sortNums[i]
            
            var r = lastR
            
            while l < r {
                
                let sumLr = sortNums[l] + sortNums[r]
                
                if sumLr == remain {
                    
                    let sss = [sortNums[i],sortNums[l],sortNums[r]]
                    res.append(sss)
                    // 去重
                    while l < r && sortNums[l] == sortNums[l + 1] {
                        l = l + 1
                    }
                    // 去重
                    while l < r && sortNums[r] == sortNums[r - 1] {
                        r = r - 1
                    }
                    l = l + 1
                    r = r - 1
                }else if sumLr < remain{
                    l = l + 1
                }else{
                    r = r - 1
                }
            }
        }
        
        return res
    }
    
    // Pow https://leetcode-cn.com/problems/powx-n/
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        if n == 0 {
            return 1
        }

        if n == -1 {
            return 1 / x
        }
        
        var half = myPow(x, n >> 1)
        
        half = half * half
        
        return ((n & 1) == 1) ? half * x : half
        
    }
    
    // 圆圈中最后剩下的数字 https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/
    
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        return (n == 1) ? 0 : (lastRemaining1(n: n - 1, m: m) + m) % n
    }

    func lastRemaining1(n : Int, m : Int) -> Int {
        
        var res = 0
        // i是数据规模，代表有多少个数字（有多少个人）
        for i in 2...n {
            res = (res + m) % i
        }
        return res
    }
    
    // 螺旋矩阵 https://leetcode-cn.com/problems/spiral-matrix/
    static  func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        
    if matrix.count == 0 {
        return []
    }
    
    /// 边界
    var left = 0
    var right = matrix[0].count - 1
    var top = 0
    var bottom = matrix.count - 1
    
    /// 总数
    var totalCount = (right + 1) * (bottom + 1)
    
    var result = [Int]()
    
    
    while totalCount >= 1 {
        
        /// 从左到右遍历
        var i = left
        while i <= right,totalCount>=1 {
            result.append(matrix[top][i])
            totalCount -= 1
            i += 1
        }
        
        top += 1
        
        /// 从上到下
        i = top
        while i <= bottom,totalCount>=1 {
            result.append(matrix[i][right])
            totalCount -= 1
            i += 1
        }
        
        right -= 1
        
        /// 从右 到 左
        i = right
        while i >= left,totalCount>=1 {
            result.append(matrix[bottom][i])
            totalCount -= 1
            i -= 1
        }
        
        bottom -= 1
        
        /// 从 下 到上
        i = bottom
        while i >= top,totalCount>=1 {
            result.append(matrix[i][left])
            totalCount -= 1
            i -= 1
        }
        
        left += 1
    }
    
    return result
    
    
}
    
    
    // 整数反转 https://leetcode-cn.com/problems/reverse-integer/
    func reverse(_ x: Int) -> Int {
        var res = 0
        var x = x
        while x != 0 {
            res = res * 10 + x%10
            if res > Int32.max || res < Int32.min {
                return 0
            }
            x = x/10
        }
        return res
    }
        
}


/*
     public List<List<Integer>> threeSum(int[] nums) {// 总时间复杂度：O(n^2)
            List<List<Integer>> ans = new ArrayList<>();
            if (nums == null || nums.length <= 2) return ans;

            Arrays.sort(nums); // O(nlogn)

            for (int i = 0; i < nums.length - 2; i++) { // O(n^2)
                if (nums[i] > 0) break; // 第一个数大于 0，后面的数都比它大，肯定不成立了
                if (i > 0 && nums[i] == nums[i - 1]) continue; // 去掉重复情况
                int target = -nums[i];
                int left = i + 1, right = nums.length - 1;
                while (left < right) {
                    if (nums[left] + nums[right] == target) {
                        ans.add(new ArrayList<>(Arrays.asList(nums[i], nums[left], nums[right])));
                        
                        // 现在要增加 left，减小 right，但是不能重复，比如: [-2, -1, -1, -1, 3, 3, 3], i = 0, left = 1, right = 6, [-2, -1, 3] 的答案加入后，需要排除重复的 -1 和 3
                        left++; right--; // 首先无论如何先要进行加减操作
                        while (left < right && nums[left] == nums[left - 1]) left++;
                        while (left < right && nums[right] == nums[right + 1]) right--;
                    } else if (nums[left] + nums[right] < target) {
                        left++;
                    } else {  // nums[left] + nums[right] > target
                        right--;
                    }
                }
            }
            return ans;
        }
    }
*/
