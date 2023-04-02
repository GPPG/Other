//
//  DFCameraViewController.swift
//  Camera
//
//  Created by Jason Wu on 2019/6/5.
//

import UIKit

class DFCameraViewController: UIViewController {
    
    @IBOutlet weak var renderView: GPUImageView!
    lazy var camera: Camera? = { return Camera.init() }()
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        camera?.renderView = renderView
        camera?.setupCamera(position: .back)
        camera?.setSquareTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        camera?.readyForQuitCamera()
        super.viewWillDisappear(true)
    }
    
    @IBAction func capturePhoto(){
        camera?.capturePhoto(complete: { photo in
            var capturePhoto = photo
            DFResultViewController.show(parent: self, image: capturePhoto.image!)
        })
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
