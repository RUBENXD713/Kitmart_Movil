//
//  estufaViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 16/04/21.
//

import UIKit
import Alamofire
import Starscream

class estufaViewController: UIViewController, WebSocketDelegate {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var btnOff: UIButton!
    @IBOutlet weak var viewMain: UIImageView!
    @IBOutlet weak var view1: UIView!
    
    let defaults = UserDefaults.standard
    
    var ultrasonico = ""
    
    private var isConnected = false
    private var socket:WebSocket!
    private var topic:String? = nil
    
    private var pingTimer:Timer?
    
    var i=0
    
    let headers:HTTPHeaders = [
        "Authorization":"Bearer \(UserDefaults.standard.object(forKey: "token") ?? "")",
        "Accept":"aplication/json"
    ]
    
    let url = "\(UserDefaults.standard.object(forKey: "url")!)estado"
    
    let urlget = "\(UserDefaults.standard.object(forKey: "url")!)sensores/D"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.round()
        viewMain.roundSuave()
        btnOn.round()
        btnOff.round()
        
        self.i=0
        
        self.modificarEstado()
        
        AF.request(urlget, method: .get,headers: headers).responseDecodable(of: [leds].self){ (response) in
            guard let sonico = response.value else {return}
            self.ultrasonico = sonico[0]._id
            print(self.ultrasonico)
            }
        
        
        wsconnect()
        event("controlEspacios", data: "actualizar_temperatura_IOS")
        
    }
    
    @IBAction func onEstufa(_ sender: UIButton) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ultrasonico)/1", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("ENCENDIDO")
            self.event("controlEspacios", data: "estufaEncendida")
        }
    }
    
    @IBAction func offEstufa(_ sender: UIButton) {
        AF.request("\(defaults.object(forKey: "url")!)estado/\(self.ultrasonico)/0", method: .put,headers: self.headers).responseDecodable(of: leds.self){ (response) in
            print("APAGADO")
            self.event("controlEspacios", data: "estufaApagado")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidLoad()
        wsconnect()
        //event("temperatura", data: "actualizar_temperatura_IOS")
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
    
    //life cycle
    
    func modificarEstado(){
        let url = "\(defaults.object(forKey: "url")!)prevencionAccidentes"
        print(url)
        AF.request(url, method: .get,headers: headers).responseDecodable(of: [registroFinalSensor].self){ (response) in
            guard let pendientes = response.value else { return }
            print(pendientes.first ?? [registroFinalSensor]())
            
            /*self.lbl1.text = pendientes[0].valor
            self.lbl2.text = pendientes[1].valor
            self.lbl3.text = pendientes[2].valor
            self.lbl4.text = pendientes[3].valor*/
            
            for x in pendientes{
                self.i = self.i+1
                if self.i == 1{self.lbl1.text = x.valor}
                if self.i == 2{self.lbl2.text = x.valor}
                if self.i == 3{self.lbl3.text = x.valor}
                if self.i == 4{self.lbl4.text = x.valor}
                if self.i == 5{break}
            }
            self.i=0
            
            
        }
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
                modificarEstado()
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
