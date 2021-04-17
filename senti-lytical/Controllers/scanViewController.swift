//
//  scanViewController.swift
//  senti-lytical
//
//  Created by David Kumar on 4/17/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit
import AVKit
import Vision

class scanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var imagePicker: UIImagePickerController?
    var keyword: String?
    var confidence: Any?
    @IBOutlet weak var cameraFeed: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAVsession()
        
        addCamera()

        // Do any additional setup after loading the view.
    }
    
    // delegate method: called every time the camera captures a frame
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
                        
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            
            guard let firstObservation = results.first else {return}
            
            self.keyword = firstObservation.identifier
            self.confidence = firstObservation.confidence
            
            print(self.keyword)
            print(self.confidence)

        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func setupAVsession(){
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else{ return }
        
        guard let input  = try? AVCaptureDeviceInput(device: captureDevice) else{ return }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        view.layer.addSublayer(previewLayer)
        
        previewLayer.frame = view.frame
        
    }
    
    func addCamera(){
        
        imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear){
            
            imagePicker?.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker?.sourceType = UIImagePickerController.SourceType.camera
            
            imagePicker?.view.frame = cameraFeed.bounds
            imagePicker?.allowsEditing = false
            imagePicker?.showsCameraControls  = false
            imagePicker?.view.autoresizingMask = [.flexibleWidth,  .flexibleHeight]
        }
    
    }
    



}
