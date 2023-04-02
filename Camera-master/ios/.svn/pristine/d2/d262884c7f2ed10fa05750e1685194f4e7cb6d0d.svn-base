//
//  FilterDataManager.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/28.
//

import Foundation
import InfoKit

class FilterDataManager {
    static let shared = FilterDataManager()
    static let lutFilterPlistName = "LUTFilter"

    struct LutFilters: Codable { let lutFilters: [LutFilter] }

    var filterDic: [String: LutFilter]?
    var thumbnails: [String: UIImage?] = [:]

    init() {
        let plist = Plist<LutFilters>("LutFilter", in: Bundle.main)
        let lut = plist.decode()
        filterDic = [:]
        let filters = lut?.lutFilters
        guard filters != nil else{
            return
        }
//        DispatchQueue.global().async { [unowned self] in
            for filter in filters!{
                self.filterDic?[filter.filterName] = filter
                //不能用global，会卡gpuimage的线程
                self.thumbnails[filter.filterName] = UIImage.init(named: filter.iconName)
            }
//        }
    }

    func getLutFilterList() -> [LutFilter]?{
        return [LutFilter].init(filterDic!.values)
    }

    @available(*, deprecated, message: "不用index了")
    func getLutImageIn(_ index: Int) -> UIImage?{
        let filter = getLutFilterList()![index]
        return UIImage.init(named: filter.imageName)
    }

    /** 加载Lut文件，但不使用缓存 */
    func getLutImage(_ name: String) -> UIImage?{
        let filename = getLutFilter(name)?.imageName
        let path = Bundle.main.path(forResource: filename, ofType: nil)
        guard path != nil else{
            return nil
        }
        let image = UIImage.init(contentsOfFile: path!)
        return image
    }

    func getLutThumbnail(_ name: String) -> UIImage?{
        return thumbnails[name] ?? nil
    }

    func getLutFilter(_ name: String) -> LutFilter?{
        return filterDic?[name]
    }

    func getSortedLutFilterList() -> [LutFilter]?{
        let sorted = getLutFilterList()?.sorted { (a, b) -> Bool in
            if a.sortGroup == b.sortGroup{
                return Int(a.baseId)! <= Int(b.baseId)!
            } else{
                return a.sortGroup <= b.sortGroup
            }

        }
        return sorted
    }
}
