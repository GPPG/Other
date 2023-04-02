//
//  PhotoEditor.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/21.
//

import Foundation
import UIKit

//默认传入这个编辑器的图片方向是正确的，不做任何旋转裁剪
class PhotoEditorViewController: UIViewController {
    @IBOutlet weak var renderView: GPUImageView!

    var photo: OriginPhoto?

    var gpuPicture: GPUImagePicture?
    var filterGroup: GPUFilterGroup?
    var filter: GPUImageFilter?

//测试美颜
    @IBOutlet weak var testStatus: UILabel!


    var beauty: YUGPUImageHighPassSkinSmoothingFilter?

    var change: GLImageFaceChangeFilterGroup?
//END

    override func viewDidLoad() {
        renderView.setBackgroundColorRed(0.2, green: 0.2, blue: 0.2, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        FacePlusPlusApi.detectFace(photo!.image!) {
            (result) in
            //脸部数据存入photo
            if let face = result?.faces?.first{
                self.testStatus.text = "OK"
                self.change?.isHaveFace = true
                self.change?.setFacePointsArray(face.sdkFormLandmark!)
            } else{
                self.testStatus.text = "ER"
                self.change?.isHaveFace = false
                self.change?.setFacePointsArray([])
            }
            self.gpuPicture?.processImage()
        }

        change = GLImageFaceChangeFilterGroup.init()
        change?.noseParam = 0
        change?.thinFaceParam = 0
        change?.eyeParam = 0
        //看下front和back的区别
        change?.setCaptureDevicePosition(.front)
        change?.isShowFaceDetectPointBool = false

        beauty = YUGPUImageHighPassSkinSmoothingFilter.init()
//        beauty?.beautyLevel = 0


        gpuPicture = GPUImagePicture.init(image: photo?.image)
        filterGroup = photo?.filterGroup

        gpuPicture?.addTarget(change)

        change?.addTarget(beauty)

//        filterGroup?.input = gpuPicture
        filterGroup?.input = beauty
        filterGroup?.output = renderView
        filterGroup?.startProcess()

        gpuPicture?.processImage()
    }

    @IBAction func faceValueChanged(_ sender: UISlider) {
        change?.thinFaceParam = sender.value

        filterGroup?.getReadyForRenderStillImage()
        gpuPicture?.processImage()
    }

    @IBAction func eyeValueChanged(_ sender: UISlider) {
        change?.eyeParam = sender.value

        filterGroup?.getReadyForRenderStillImage()
        gpuPicture?.processImage()
    }

    @IBAction func noseValueChanged(_ sender: UISlider) {
        change?.noseParam = sender.value

        filterGroup?.getReadyForRenderStillImage()
        gpuPicture?.processImage()
    }

    @IBAction func beautyValueChanged(_ sender: UISlider) {
        beauty?.amount = CGFloat(sender.value)
        gpuPicture?.processImage()
    }

    @IBAction func tone(_ sender: UISlider) {
//        beauty?.toneLevel = CGFloat(sender.value)
        gpuPicture?.processImage()
    }

    @IBAction func bright(_ sender: UISlider) {
//        beauty?.brightLevel = CGFloat(sender.value)
        gpuPicture?.processImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        gpuPicture?.processImage()
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
    }

    @IBAction func process(){
//        filterGroup!.filterForRender!.useNextFrameForImageCapture()
//        gpuPicture!.processImage()

        let filterForRender = GPUImageFilter.init()
        filterGroup?.filterForRender?.addTarget(filterForRender)


        filterForRender.useNextFrameForImageCapture()
        filterGroup?.getReadyForRenderStillImage()
        gpuPicture!.processImage()

        let aa = filterForRender.imageFromCurrentFramebuffer()
        UIImageWriteToSavedPhotosAlbum(aa!, nil, nil, nil)
        print("Process done")

        filterGroup?.filterForRender?.removeTarget(filterForRender)
    }

    @IBAction func changed(_ sender: UISlider) {
        let filter =  filterGroup?.getFilterAndIndex(identifier: "lookup")?.1
        filter?.strength = sender.value
        gpuPicture?.processImage()
    }

    @IBAction func adjustAction(_ sender: Any) {
        
        let adjustVC = AdjustViewController()
        adjustVC.adjustImage =  photo?.image
        self.present(adjustVC, animated: true, completion: nil)
    }
    
    @IBAction func cropAction(_ sender: Any) {
        
        let cropVC = CropViewController()
        cropVC.cropImage = photo?.image
        self.present(cropVC, animated: true, completion: nil)
    }
    
    func rotate(){

    }

    @IBAction func exit(){
        dismiss(animated: true, completion: nil)
    }
}

