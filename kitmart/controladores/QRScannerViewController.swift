//
//  QRScannerViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 14/04/21.
//

import UIKit
import AVFoundation

struct RecetaQR:Codable {
    var name:String
    var ingredientes:String
    var preparacion:String
}

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var Receta = ""
    
    override func viewDidLoad() {
        
        print("entro a la vista")
        view.backgroundColor = .black
        super.viewDidLoad()
        
        // Background Color
        //view.backgroundColor = .cyan
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {return}
        print(videoCaptureDevice)
        let videoInput:AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else{
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput){
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        print("Capturando")
        // Do any additional setup after loading the view.
    }
    
    func Failed(){
        let ac = UIAlertController(title: "No soparta", message: "Tu dispositivo no es compatible con esta funcion", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if captureSession.isRunning{
            captureSession.stopRunning()
        }
        
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first{
            guard let readable = metadataObject as? AVMetadataMachineReadableCodeObject
            else {return}
            guard let stringValue = readable.stringValue else {return}
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundTextFromQR(stringValue)
        }
        dismiss(animated: true)
        
        }
    
    func foundTextFromQR(_ stringValue:String){
        print(stringValue)
        
        if let data = stringValue.data(using: .utf8){
            print(data)
            
            do{
                let recetasecreta:RecetaQR = try! JSONDecoder().decode(RecetaQR.self, from: data)
                let ac = UIAlertController(title: "Receta Secreta", message:"nombre: " + recetasecreta.name + " Ingredientes: " + recetasecreta.ingredientes + " Preparacion: " + recetasecreta.preparacion , preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "terminar", style: .default))
                print("nombre: " + recetasecreta.name + " Ingredientes: " + recetasecreta.ingredientes + " Preparacion: " + recetasecreta.preparacion)
            }
        }else{
            print("Error de serialización")
        }
    }
    
    
 
}
