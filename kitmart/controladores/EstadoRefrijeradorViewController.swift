//
//  EstadoRefrijeradorViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 15/04/21.
//

import UIKit
import Alamofire
import Starscream

class EstadoRefrijeradorViewController: UIViewController, WebSocketDelegate {

    @IBOutlet weak var lbltemperatura: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblEstado: UILabel!
    
    private var isConnected = false
    private var socket:WebSocket!
    private var topic:String? = nil
    
    let defaults = UserDefaults.standard
    
    private var pingTimer:Timer?
    
    let headers:HTTPHeaders = [
        "Authorization":"Bearer \(UserDefaults.standard.object(forKey: "token") ?? "")",
        "Accept":"aplication/json"
    ]
    
    let url = "\(UserDefaults.standard.object(forKey: "url")!)estadoRefri"
    let urlTemp = "\(UserDefaults.standard.object(forKey: "url")!)temperaturaRefri"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.roundSuave()
        recuperarHumedad()
        wsconnect()
        event("controlEspacios", data: "actualizar_controlEspacions_IOS")
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidLoad()
        wsconnect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        event("controlEspacios", data: "Control espacios IOS")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidLoad()
        wsdisconnect()
    }
    
    
    func wsconnect(){
        var request = URLRequest(url: URL(string: "ws://127.0.0.1:3333/adonis-ws")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func wsdisconnect(){
        socket.disconnect()
    }
    
    func recuperarHumedad()
    {
        AF.request(self.url, method: .get,headers: self.headers).responseDecodable(of: [registroFinalSensor].self){ (response) in
            guard let humedad = response.value else { return }
            print(humedad)
            
            if humedad[0].valor != nil
            {
                self.lblEstado.text = "\(humedad[0].valor)"
            }
            else{
                self.lblEstado.text = "close"
            }
        }
        AF.request(self.urlTemp, method: .get,headers: self.headers).responseDecodable(of: [registroFinalSensor].self){ (response) in
            guard let temperatura = response.value else { return }
            print(temperatura)
            
            if temperatura[0].valor != nil
            {
                self.lbltemperatura.text = "\(temperatura[0].valor)º"
            }
            else{
                self.lbltemperatura.text = "0º"
            }
        }
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
                recuperarHumedad()
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
