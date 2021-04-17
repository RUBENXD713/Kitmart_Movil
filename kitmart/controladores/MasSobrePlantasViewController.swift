//
//  MasSobrePlantasViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 16/04/21.
//

import UIKit
import WebKit

class MasSobrePlantasViewController: UIViewController, WKNavigationDelegate
{

    var webview:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview = WKWebView()
        webview.navigationDelegate = self
        
        self.view = webview
        
        let url = URL(string: "https://www.verdeesvida.es/")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
