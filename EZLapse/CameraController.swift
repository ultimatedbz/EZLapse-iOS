//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Russell Austin on 1/23/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var previewView: UIView!
  @IBOutlet weak var capturedImage: UIImageView!
  
  var captureSession: AVCaptureSession?
  var stillImageOutput: AVCaptureStillImageOutput?
  var previewLayer: AVCaptureVideoPreviewLayer?
  var firstPic: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    capturedImage.contentMode = UIViewContentMode.ScaleAspectFill
    
    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    let documentsDirectory: AnyObject = paths[0]
    let dataPath = documentsDirectory.stringByAppendingPathComponent("dummy")
    
    do {
      let manager = NSFileManager.defaultManager()
      try manager.createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
    } catch let error as NSError {
      print(error.localizedDescription);
    }
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    captureSession = AVCaptureSession()
    captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
    
    let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    var error: NSError?
    var input: AVCaptureDeviceInput!
    do {
      input = try AVCaptureDeviceInput(device: backCamera)
    } catch let error1 as NSError {
      error = error1
      input = nil
    }
    
    if error == nil && captureSession!.canAddInput(input) {
      captureSession!.addInput(input)
      
      stillImageOutput = AVCaptureStillImageOutput()
      stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
      if captureSession!.canAddOutput(stillImageOutput) {
        captureSession!.addOutput(stillImageOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
        previewView.layer.addSublayer(previewLayer!)
        
        captureSession!.startRunning()
      }
    }
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    previewLayer!.frame = previewView.bounds
  }
  
  @IBAction func didPressTakePhoto(sender: UIButton) {
    
    if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
      videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
      stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
        if (sampleBuffer != nil) {
          let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
          let dataProvider = CGDataProviderCreateWithCFData(imageData)
          let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
          
          let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
          self.capturedImage.image = image
          
          

          
          //TODO assume for now that directory /dummy/ has already been made.
          
          //What I want to do:
          // get size of /dummy/
          // store picture at dummy/[size].jpg
          print(self.getPATHofNextPic())
      
        }
      })
    }
    
  }
  
  func getPATHofNextPic() -> String {
    
    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    var documentsDirectory: String = paths[0]
    documentsDirectory = documentsDirectory + "/dummy"
    
    var size = 0;
    do{
    size = try NSFileManager().contentsOfDirectoryAtPath(documentsDirectory).count
    }catch let error as NSError {
      print(error.localizedDescription)
    }
    return documentsDirectory + "/\(size).jpg"
  }

  func writeImageToDisk(image: UIImage,  url: NSURL) {
    
    let imageData = UIImagePNGRepresentation(image)
    imageData!.writeToURL(url, atomically: true)
    
  }

  
  @IBAction func didPressTakeAnother(sender: AnyObject) {
    captureSession!.startRunning()
  }
  
  
}

