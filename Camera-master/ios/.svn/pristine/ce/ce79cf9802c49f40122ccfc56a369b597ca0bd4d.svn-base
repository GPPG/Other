//
//  TestCameraViewController.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/20.
//

import Foundation
import UIKit
import GPUImage
import MediaPlayer

class CameraViewController: UIViewController {
    @IBOutlet weak var renderView: GPUImageView!

    @IBOutlet weak var poseImageView: UIImageView!

    lazy var camera: Camera? = { return Camera.init() }()
    var toolbar: CameraToolbarNavigationController?

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(capturePhoto), name: .init("AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents()

        let volume = MPVolumeView.init(frame: CGRect(x: -20, y: -20, width: 10, height: 10))
        volume.isHidden = false
        view.addSubview(volume)

    }

    @IBAction func flash(_ sender: UIButton) {
        camera?.toggleFlashlight()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        camera?.renderView = renderView
        camera?.setupCamera()
    }

    override func viewWillDisappear(_ animated: Bool) {
        camera?.readyForQuitCamera()
        super.viewWillDisappear(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        camera?.group?.getFilterAndIndex(identifier: "lookup")?.1.strength = sender.value
    }

    @IBAction func switchCamera(){
        camera?.rotateCamera()
    }

    @IBAction func capturePhoto(){
        camera?.capturePhoto(complete: { [unowned self] (photo) in
            EditorManager.showEditor(parent: self, photo: photo)
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toolbar"{
            toolbar = segue.destination as? CameraToolbarNavigationController
            toolbar?.cameraDelegate = self
        }
    }

    @IBAction func openPose(_ sender: Any) {
        toolbar?.jumpPose()
    }

    @IBAction func openFilter(_ sender: Any) {
        toolbar?.jumpFilter()
    }
}

extension CameraViewController: CameraToolbarNavigationController.CameraFunctionDelegate{
    func selectedPose(catalogy: PoseCatalogy, index: Int) {
        poseImageView.image = PoseDataManager.shared.getPosePicture(catalogy: catalogy, index: index)
    }

    func hidePose() {
        poseImageView.image = nil
    }

    func selectLutFilter(name: String) {
        camera?.addLutFilter(name: name)
    }
}


extension CameraViewController{
    override var prefersStatusBarHidden: Bool{
        get{ return true }
    }
}
