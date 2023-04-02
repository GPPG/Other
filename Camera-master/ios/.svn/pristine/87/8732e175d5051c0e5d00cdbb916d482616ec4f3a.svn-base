//
//  PhotoRaw.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/21.
//

import Foundation

struct OriginPhoto {
    var raw: AVCapturePhoto?
    var data: Data?{
        get { return raw?.fileDataRepresentation() }
    }
    lazy var image: UIImage? = {
        guard data != nil else {
            return nil
        }
        return UIImage.init(data: data!)?.fixOrientation(rear: self.position == .front).fixOrientation()
    }()
    var originImage: UIImage?{
        get{
            return UIImage.init(data: data!)
        }
    }
    var filterGroup: GPUFilterGroup?
    var position: AVCaptureDevice.Position? = .back
    var face: [FPPModel.Detect.Face] = []

    var faceRects: [CGRect] = []

    init(raw: AVCapturePhoto, filterGroup: GPUFilterGroup?) {
        self.raw = raw
        self.filterGroup = filterGroup
    }

    init(image: UIImage) {
        self.image = image
    }

    func a(){

    }
}
