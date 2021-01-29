//
//  ViewController.swift
//  WebDisplayEngine
//
//  Created by EasonTek on 23/1/21.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    var loadingStatus:Float = 0.0
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
   
    override func viewDidLoad() {
        // COMMENT this if you want to load a remote page
        let html = //UNCOMMENT THESE
"""
        <html>
            <meta>
            </meta>
            <body>
                <h1>WebDisplayEngine</h1>
                <p>Version 1.0</p>
                <p>(C)EasonTek 2021</p>
            </body>
        </html>
"""
//Comment all this orange stuff to load remote page
        super.viewDidLoad()
        // uncomment to load remote page
        //if let url = URL(string: "https://www.apple.com/") {
            //let request = URLRequest(url: url)
            //webView.load(request)
            //webView.allowsBackForwardNavigationGestures = true
            //webView.addObserver(self, forKeyPath: //#keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        //}
        //UNCOMMENT ALL OF THIS TO LOAD A REMOTE PAGE
        webView.loadHTMLString(html, baseURL: URL(string: "https://blank.org")) //uncomment this
        webView.allowsBackForwardNavigationGestures = true//uncomment this
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) //uncomment this
        
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            loadingStatus = Float(webView.estimatedProgress)
            if loadingStatus < 0.999 {
                
                progressBar.isHidden = false
                
                progressBar.progress = loadingStatus
                
            } else if loadingStatus > 0.999 {
                
                progressBar.progress = 0
                progressBar.isHidden = true
                
            }
            
        }
    }

}

