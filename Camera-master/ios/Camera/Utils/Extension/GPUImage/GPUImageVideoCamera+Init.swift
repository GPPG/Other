//
//  GPUImageVideoCamera+Init.swift
//  Camera
//
//  Created by HuangMingXi-G on 2019/5/21.
//

import GPUImage
import Foundation

extension GPUImageVideoCamera{
    convenience init(preset: AVCaptureSession.Preset, position: AVCaptureDevice.Position) {
        self.init(sessionPreset: preset.rawValue, cameraPosition: position)
    }
}
