//
//  SortArray.swift
//  LeetCode
//
//  Created by 郭鹏 on 2021/6/15.
//  Copyright © 2021 郭鹏. All rights reserved.
//

import UIKit

class SortArray: NSObject {
    
    // 冒泡排序
    func BubbleSort(array: [Int]) -> [Int]{
        
        var tempArray = array
        
        let count = array.count - 1
        
        for i in (1...count).reversed() {
                        
            for j in 0...(i - 1) {
                print(j)

                if tempArray[j] > tempArray[j + 1] {
                    tempArray.swapAt(j, j + 1)
                }
            }
        }
        return tempArray
    }
    
    
    // 冒泡排序优化,完全有序的情况
    func BubbleSort1(array: [Int]) -> [Int]{
        
        var tempArray = array
        
        let count = array.count - 1
        
        for i in (1...count).reversed() {
            
            var sorted = true
            
            
            for j in 0...(i - 1) {
                print(j)
                
                if tempArray[j] > tempArray[j + 1] {
                    tempArray.swapAt(j, j + 1)
                    sorted = false;
                }
            }
            
            if sorted == true {break}
            
        }
        return tempArray
    }
    
    
    // 冒泡排序优化,尾部有序,减少尾部比较次数
    func BubbleSort2(array: [Int]) -> [Int]{
        
        var tempArray = array
        
        var swap = 0 //swap变量用来标记循环里最后一次交换的位置
        
        let count = array.count
        
        var k = count - 1 //内循环判断条件
        
        for _ in 0..<count {
            
            var flag = true
            
            for j in 0..<k {
                print(j)
                
                if tempArray[j] > tempArray[j + 1] {
                    tempArray.swapAt(j, j + 1)
                    flag = false
                    swap = j
                }
            }
            
            k = swap
            
            if flag {
                break
            }
        }
        return tempArray
    }

    // 选择排序
    func SelectionSort(array: [Int]) -> [Int]{
        
        var tempArray = array

        let count = tempArray.count - 1
        
        
        for lastIndex in (0...count).reversed() {
            
            var max = 0
            for j in 0...lastIndex {
                if tempArray[j] > tempArray[max] {
                    max = j
                }
            }
            print(max)
            tempArray.swapAt(max, lastIndex)
        }
        return tempArray
    }
    
    // 堆排序
    func heapSort(arr:inout Array<Int>) {
        //1.构建大顶堆
        for i in (0...(arr.count/2-1)).reversed(){//从二叉树的一边的最后一个节点开始
            //从第一个非叶子结点从下至上，从右至左调整结构
            adjustHeap(arr: &arr, i: i, length: arr.count)
        }
        //2.调整堆结构+交换堆顶元素与末尾元素
        for j in (1...(arr.count-1)).reversed(){
            arr.swapAt(0, j)//将堆顶元素与末尾元素进行交换
            adjustHeap(arr: &arr, i: 0, length: j)//重新对堆进行调整
        }
    }
    // 调整大顶堆（仅是调整过程，建立在大顶堆已构建的基础上）
    func adjustHeap(arr:inout Array<Int>,i:Int,length:Int) {
        var i = i;
        let temp = arr[i];//先取出当前元素i
        var k=2*i+1
        while k<length {//从i结点的左子结点开始，也就是2i+1处开始
            if(k+1<length && arr[k]<arr[k+1]){//如果左子结点小于右子结点，k指向右子结点
                k+=1;
            }
            if(arr[k] > temp){//如果子节点大于父节点，将子节点值赋给父节点（不用进行交换）
                arr[i] = arr[k];
                i = k;//记录当前节点
            }else{
                break;
            }
            k=k*2+1//下一个节点
        }
        arr[i] = temp;//将temp值放到最终的位置
    }
    
    // 插入排序
    func InsertionSort(array: [Int]) -> [Int] {
        
        var sortArray = array
        
        let count = sortArray.count - 1
        
        for cur in 1...count {
            
            var j = cur
            
            while j > 0 && sortArray[j] < sortArray[j - 1] {
                
                sortArray.swapAt(j, j - 1)
                j -= 1
            }
        }
        return sortArray
    }
    // 插入排序优化,先备份,再右移,最后赋值
    func InsertionSort1(array: [Int]) -> [Int] {
        
        var sortArray = array
        
        let count = sortArray.count - 1
        
        for cur in 1...count {
            
            var j = cur
            
            let v = sortArray[j]
            
            
            while j > 0 && v < sortArray[j - 1] {
                
                sortArray[j] = sortArray[j - 1]
                j -= 1
            }
            
            sortArray[j] = v
        }
        return sortArray
    }
    
    // 插入排序优化,二分查找最佳位置
    func InsertionSort2(array: [Int]) -> [Int] {
        var sortArray = array
        
        let count = sortArray.count - 1
        
        for cur in 1...count {
            
            let dest = search(index: cur, array: sortArray)
            let v = sortArray[cur]
            var j = cur
            
            while j > dest {
                sortArray[j] = sortArray[j - 1]
                j -= 1
            }
            
            sortArray[dest] = v
        }
        
        return sortArray
        
    }
    
    
    // 二分查找
    func search(index: Int,array: Array<Int>) -> Int {
        
        var begin = 0
        var end = index
        
        while begin < end {
            
            var mid = (begin + end) >> 1
            
            if array[index] < array[mid] {
                end = mid
            }else{
                begin = mid + 1
            }
        }
        return begin
        
        
        
        
    }
    
}
