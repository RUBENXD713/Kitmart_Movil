//
//  InspiracionViewController.swift
//  kitmart
//
//  Created by mac15 on 26/03/21.
//

import UIKit
import Alamofire
import WebKit

class InspiracionViewController: UIViewController, WKNavigationDelegate
{
    var webview:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview = WKWebView()
        webview.navigationDelegate = self
        
        self.view = webview
        
        let url = URL(string: "https://www.recetasgratis.net/")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
}
