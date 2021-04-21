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
    var fieldurl = "https://www.xflymusic.com/"
    override func viewDidLoad() {
        super.viewDidLoad()
        //uncomment to load remote page
       
        if let url = URL(string: fieldurl) {
           let request = URLRequest(url: url)
           webView.load(request)
           webView.allowsBackForwardNavigationGestures = true
           webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
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
