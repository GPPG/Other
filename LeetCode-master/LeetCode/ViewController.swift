//
//  ViewController.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/6.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        var array1 = [1,2,3,4,0,0,0]
//        let array2 = [2,4,6]
//
//        LeetArray.merge(&array1, 4, array2, 3)
//
//        print(array1)
        
//        var array = [0,1,2,2,1,1,2,0,2]
//
//        LeetArray.sortColors(&array)
//
//        print(array)
        
//        var array = [1,5,4,3,2,6,7]
//
//       print(LeetArray.subSort(array))
        
        
//        let array = [-7,-3,2,3,5,11]
//        print(LeetArray.sortedSquares(array))
        
//        let l2 = ListNode(2)
//        let l1 = ListNode(1, l2)
//        let l0 = ListNode(0, l1)

//        let l = LeetList.removeElements1(l0, 1)
//        print(l?.next?.val ?? 111)
//        print(l?.next?.next ?? l0)
//        print(l?.next?.next?.next?.val ?? 111)

//        p(node: l!)
        
//        let array = [-1,0,1,2,-1,-4,-2,-3,3,0,4]
//
//        let ss = LeetCode.threeSum(array)
//
//        print(ss)
        
//        let array = [[1,2,3],[4,5,6],[7,8,9]]
//        let ss = LeetCode.spiralOrder(array)
//        print(ss)
        
//        ["LRUCache","put","put","get","put","get","put","get","get","get"]
//        [[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]
//
//        let cache = LRUCache.init(2)
//        cache.put(2, 2)
//        cache.put(3, 3)
//        cache.put(4, 4)
//      print(cache.get(2))


        let a = [1,5,2,6,3,3,1]
        
        let aa = [1,2,3,4,5,6,7]
        
        let aaa = [1,5,2,7,8,9,10]

        let  sss = SortArray()
        
        let array = sss.InsertionSort2(array: a)
        
        print(array)
        
        
      
        
        
        
    }
   

}

