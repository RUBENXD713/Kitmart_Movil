//
//  FocosViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 16/04/21.
//

import UIKit
import Alamofire
import Starscream

struct leds:Decodable {
    let _id: String
    let nombre: String
    let descripcion: String
    let tipo: String
    let pinIn: String?
    let pinOut: String
    let estado: String
    let created_at: String
    let updated_at: String
}

class FocosViewController: UIViewController, WebSocketDelegate {

    
    @IBOutlet weak var f1Apagar: UIButton!
    @IBOutlet weak var f1Encender: UIButton!
    @IBOutlet weak var f2Apagar: UIButton!
    @IBOutlet weak var f2Encender: UIButton!
    @IBOutlet weak var f3Apagar: UIButton!
    @IBOutlet weak var f3Encender: UIButton!
    @IBOutlet weak var lblF1: UILabel!
    @IBOutlet weak var lblF2: UILabel!
    @IBOutlet weak var lblF3: UILabel!
    
    private var isConnected = false
    private var socket:WebSocket!
    private var topic:String? = nil
    
    let defaults = UserDefaults.standard
    
    var ledsArray = [leds]()
    
    private var pingTimer:Timer?
    
    let headers:HTTPHeaders = [
        "Authorization":"Bearer \(UserDefaults.standard.object(forKey: "token") ?? "")",
        "Accept":"aplication/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        f1Apagar.circular()
        f1Encender.circular()
        f2Apagar.circular()
        f2Encender.circular()
        f3Apagar.circular()
        f3Encender.circular()
        
        let url = "\(defaults.object(forKey: "url")!)sensores/E"
        print(url)
        AF.request(url, method: .get,headers: self.headers).responseDecodable(of: [leds].self){ [self] (response) in
            if response.value != nil
            {
                self.ledsArray = response.value!
                print(self.ledsArray.first ?? [Pendiente]())
                self.lblF1.text = self.ledsArray[0].nombre
                self.lblF2.text = self.ledsArray[1].nombre
                self.lblF3.text = self.ledsArray[2].nombre
            }
            
        }
        
        wsconnect()
        
    }
    
    @IBAction func funcionApagar1(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[0]._id)/0", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("APAGADO")
            self.event("led", data: "Led1Apagado")
        }
    }
    
    @IBAction func funcionApagar2(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[1]._id)/0", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("APAGADO")
            self.event("led", data: "Led2Apagado")
        }
    }
    
    @IBAction func funcionApagar3(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[2]._id)/0", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("APAGADO")
            self.event("led", data: "Led3Apagado")
        }
    }
    
    
    @IBAction func funcionEncender1(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[0]._id)/1", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("ENCENDIDO")
            self.event("led", data: "Led1Encendido")
        }
    }
    
    @IBAction func funcionEncender2(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[1]._id)/1", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("ENCENDIDO")
            self.event("led", data: "Led2Encendido")
        }
    }
    
    @IBAction func funcionEncender3(_ sender: Any) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ledsArray[2]._id)/1", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("ENCENDIDO")
            self.event("led", data: "Led3Encendido")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wsdisconnect()
    }
    
    
    
    
    func wsconnect(){
        var request = URLRequest(url: URL(string: "\(String(describing: defaults.object(forKey: "WS") ?? ""))")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func wsdisconnect(){
        socket.disconnect()
    }
    
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
                self.joinTopic("kitmart")
                self.pingTimer = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
                self.pingTimer?.fire()
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text:\(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
                self.onNewData(data)
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(_):
                isConnected = false
            }
    }
    
    @objc func ping() {
        self.sendData(type: 8, data: nil)
    }
    func joinTopic(_ topic:String){
        self.sendData(type: 1, data: ["topic":topic])
        self.topic = topic
    }
    
    func leaveTopic(_ topic:String){
        self.sendData(type: 2, data: ["topic":topic])
        self.topic = nil
    }
    
    func event(_ event:String, data:String){
        self.sendData(type: 7, data: ["topic":self.topic ?? "", "event":event  ,"data":data])
    }
    
    func onNewData(_ data:Data) {
        //let decoder = JSONDecoder()
        do {
            let text = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("data received to text: \(text)")
            
        }catch {
            print("Error de serializacion")
        }
    }
    
    
    func sendData(type:Int, data:[String:Any]?){
        let packet = ["t":type,"d":data ?? [:]] as [String : Any]
        do {
            let data = try JSONSerialization.data(withJSONObject: packet, options: .fragmentsAllowed)
            socket.write(data: data)
            print(data)
        }catch {
            print("Error de serializacion")
        }
    }

}
