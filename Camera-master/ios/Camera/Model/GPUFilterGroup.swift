//
//  FilterGroup.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/22.
//

import Foundation
import GPUImage

/**
 基于GPUImageFilterGroup的包装
 */
class GPUFilterGroup {
    private var filters: [GPUFilter] = []

    /** 主输入，通常用来存相机 */
    unowned var input: GPUImageOutput?
    /** 主输出，存下一个滤镜组或者画布 */
    unowned var output: GPUImageInput?

    var inProcessing: Bool = false


    /** 作为上一个组的输入接口 */
    var filterForConnect: GPUImageInput?{
        get{
            if filters.count == 0{
                return output
            } else{
                return (filters[0].base as! GPUImageInput)
            }
        }
    }

    /** 用来渲染静态图片的最后一个滤镜 */
    var filterForRender: GPUImageOutput?{
        get{
            if filters.count == 0{
                return input
            } else{
                for filter in filters{
                    filter.readyForRenderStillImage()
                }
                return (filters.last?.base as! GPUImageOutput)
            }
        }
    }

    /** 使用这个方法时不要加入已经process的滤镜 */
    func addFilter(_ filter: GPUFilter){
        if filter.inProcessing{
            filter.stopProcess()
        }

        let index = filters.count//滤镜即将加入的位置
        getPreviousOutput(index: index)?.removeAllTargets()
        filter.input = getPreviousOutput(index: index)
        filter.output = getNextInput(index: index)
        filters.append(filter)

        if inProcessing{//滤镜组已经开始工作的情况下直接打开新加的滤镜
            filter.startProcess()
        }

    }

    func removeFilter(identifier: String){
        let filter = getFilterAndIndex(identifier: identifier)
        guard let pair = filter else{
            return
        }
        let index = pair.0
        let filterToRemove = pair.1
        filterToRemove.stopProcess()//切断滤镜与输入输出的关系
        filterToRemove.input?.addTarget(filterToRemove.output)//滤镜输入直连输出
        filters.remove(at: index)//从组内移除
    }

    func getFilterAndIndex(identifier: String) -> (Int,GPUFilter)?{
        for (index, filter) in filters.enumerated(){
            if filter.identifier == identifier{
                return (index, filter)
            }
        }
        return nil
    }

    func getFilterIndex(identifier: String) -> Int?{
        return getFilterAndIndex(identifier: identifier)?.0
    }

    func getFilter(identifier: String) -> GPUFilter?{
        return getFilterAndIndex(identifier: identifier)?.1
    }

    func startProcess(){
        guard inProcessing != true else{
            return
        }
        inProcessing = true
        if filters.count == 0{
            input?.addTarget(output)
            //虽然没滤镜的情况下的确是会直接连起来但是有必要吗
        }
        for (index, filter) in filters.enumerated(){
            filter.input = getPreviousOutput(index: index)
            filter.output = getNextInput(index: index)
            filter.startProcess()
        }

    }

    func stopProcess(){
        guard inProcessing != false else {
            return
        }
        inProcessing = false
        input?.removeAllTargets()
        filterForRender?.removeAllTargets()
        for filter in filters{
            filter.stopProcess()
        }
    }

    func getReadyForRenderStillImage(){
        for filter in filters{
            filter.readyForRenderStillImage()
        }
    }

//    /** 获取上一个接受输入的GPUImageInput，没有上一个的情况下获取主output */
//    fileprivate func getPreviousInput(index: Int) -> GPUImageInput?{
//        if filters.count == 0{
//            return output
//        } else{
//            return (filters[max(0, index - 1)].base as! GPUImageInput)
//        }
//
//    }

    /** 获取上一个输出数据的GPUImageOutput，没有上一个的情况下获取主input */
    fileprivate func getPreviousOutput(index: Int) -> GPUImageOutput?{
        if index <= 0 || filters.count == 0{
            return input
        } else{
            return (filters[index - 1].base as! GPUImageOutput)
        }

    }

    /** 获取下一个接受输入的GPUImageInput，没有下一个的情况下获取住output */
    fileprivate func getNextInput(index: Int) -> GPUImageInput?{
        if index >= filters.count - 1 || filters.count == 0{
            return output
        } else{
            return (filters[index + 1].base as! GPUImageInput)
        }
    }

//    /** 获取最后一个输出数据的GPUImageOutput，没有的情况下返回主input */
//    fileprivate func getNextOutput(index: Int) -> GPUImageOutput?{
//        if index <= 0 || filters.count == 0{
//            return input
//        } else{
//            let lastIndex = min(index + 1, filters.count - 1)
//            return (filters[lastIndex].base as! GPUImageOutput)
//        }
//    }
}
