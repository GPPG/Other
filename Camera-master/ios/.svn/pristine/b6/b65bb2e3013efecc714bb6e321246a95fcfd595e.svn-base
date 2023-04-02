//
//  PoseDataManager.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/28.
//

import Foundation

class PoseDataManager {
    static let shared = PoseDataManager()
    var thumbnails: [String: UIImage?] = [:]

    init() {
        loadAllThumbnails()
    }

    fileprivate func loadAllThumbnails(){
        //这里会卡住，需要做一个载入处理
        let allCatalogy = [PoseCatalogy.Girl,
                           PoseCatalogy.Boy,
                           PoseCatalogy.Couple,
                           PoseCatalogy.Party]
        DispatchQueue.global().async { [unowned self] in
            for c in allCatalogy{
                for i in (0...self.getPoseCount(catalogy: c)){
                    //不能用global，会卡gpuimage的线程

                        let name = self.getPoseBaseFilename(catalogy: c, index: i)
                        let image = self.loadPoseThumbnail(name: name)
                        self.thumbnails[name] = image
                    }
            }
        }
    }

    func empty(){
        //啥都不会做，只是好看（
    }

    func getPoseCount(catalogy: PoseCatalogy) -> Int{
        switch catalogy {
        case .Boy:
            return 8
        case .Girl:
            return 10
        case .Couple:
            return 8
        case .Party:
            return 8
        }
    }

    fileprivate func loadPoseThumbnail(name: String) -> UIImage?{
        return UIImage.init(named: name+"s")
    }

    func getPoseThumbnail(catalogy: PoseCatalogy, index: Int) -> UIImage?{
        let name = getPoseBaseFilename(catalogy: catalogy, index: index)
        return thumbnails[name] ?? nil
//        return UIImage.init(named: name+"s")
    }

    func getPosePicture(catalogy: PoseCatalogy, index: Int) -> UIImage?{
        let name = getPoseBaseFilename(catalogy: catalogy, index: index)
        return UIImage.init(named: name)
    }

    fileprivate func getPoseBaseFilename(catalogy: PoseCatalogy, index: Int) -> String{
        var name = "line-"
        switch catalogy {
        case .Boy:
            name += "man"
        case .Girl:
            name += "woman"
        case .Couple:
            name += "couple"
        case .Party:
            name += "friends"
        }
        name += "-\(index+1)"
        return name
    }



}
