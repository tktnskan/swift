//
//  BarcodeViewController.swift
//  NoJapan
//
//  Created by Jinyung Yoon on 26/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import Foundation


//
//  ViewController.swift
//  barcode
//
//  Created by Jinyung Yoon on 23/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var cameraView: CameraView!
    var isShowingAlert = false
    var comment: String = ""
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: "Session Queue")
//
//
    override func loadView() {
        cameraView = CameraView()
        
        view = cameraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "Barcode Scanner"
        session.beginConfiguration()
        
        if let videoDevice = AVCaptureDevice.default(for: .video) {
            if let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
                session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (session.canAddOutput(metadataOutput)) {
                session.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [
                    .code128,
                    .code39,
                    .code93,
                    .ean13,
                    .ean8,
                    .qr,
                    .upce
                ]
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            }
        }
        
        session.commitConfiguration()
        
        cameraView.layer.session = session
        cameraView.layer.videoGravity = .resizeAspectFill
        
        cameraView.updateOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        cameraView.updateOrientation()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if !isShowingAlert,
            metadataObjects.count > 0,
            metadataObjects.first is AVMetadataMachineReadableCodeObject,
            let scan = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            print(type(of: scan.stringValue!))
            let a: String = scan.stringValue!
            let range = a.startIndex...a.index(after: a.startIndex)
            var msg: String = ""
            
            let alertController = UIAlertController(title: "Barcode Scanned", message: msg, preferredStyle: .alert)
            
            if a[range] == "49" || a[range] == "45" {
                msg = "Stop! This is made in Japan"
            } else {
                msg = "You can buy it. This is not from Japan"
            }
            
            alertController.message = msg
            
            isShowingAlert = true
            
            
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { action in
                self.isShowingAlert = false
            })
            
            present(alertController, animated: true)
        }
    }
}

class CameraView: UIView {
    override class var layerClass: AnyClass {
        get {
            return AVCaptureVideoPreviewLayer.self
        }
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        get {
            return super.layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    func updateOrientation() {
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeRight
            
        case .landscapeRight:
            videoOrientation = .landscapeLeft
            
        default:
            videoOrientation = .portrait
        }
        
        layer.connection?.videoOrientation = videoOrientation
    }
    
}

