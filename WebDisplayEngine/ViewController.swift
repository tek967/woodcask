//
//  ViewController.swift
//  wde
//
//  Created by EasonTek on 23/1/21.
//

import UIKit
import WebKit
import Darwin

class ViewController: UIViewController {
    var loadingStatus:Float = 0.0
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    var toggleState:Bool = false
    @IBOutlet weak var noLabel: UILabel!
    @IBAction func toggler(_ sender: UISwitch) {
        if toggleState == false{
            toggleState = true
            print("yes")
        } else if toggleState == true{
            toggleState = false
            print("no")
        }
    }
    @IBAction func reloadButton(_ sender: Any) {
        webView.reload()
    }
    @IBAction func previousButton(_ sender: Any) {
        if webView.canGoBack == true {
            webView.goBack()
        } else {
            noLabel.isHidden = false
            sleep(1)
            noLabel.isHidden = true

        }
    }
    @IBAction func forwardButton(_ sender: Any) {
        if webView.canGoForward == true {
            webView.goForward()
        } else {
            noLabel.isHidden = false
            sleep(1)
            noLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://xflymusic.com/weishijisheqvredirectforwde/index.html") {
            noLabel.isHidden = true
            let request = URLRequest(url: url)
            webView.load(request)
            webView.allowsBackForwardNavigationGestures = true
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            loadingStatus = Float(webView.estimatedProgress)
            if loadingStatus < 0.85 {
                progressLabel.isHidden = false
                progressSpinner.isHidden = false
                progressSpinner.startAnimating()
                progressLabel.text = String(loadingStatus * 100) + "%"
                if toggleState == true {
                    webView.isHidden = true
                } else if toggleState == false {
                    webView.isHidden = false
                }
            } else if loadingStatus > 0.85 {
                if toggleState == true {
                    webView.isHidden = false
                    progressSpinner.stopAnimating()
                    progressLabel.text = "%"
                    progressSpinner.isHidden = true
                    progressLabel.isHidden = true
                } else if toggleState == false {
                    
                    print("NONONONO")
                    progressSpinner.stopAnimating()
                    progressLabel.text = "%"
                    progressSpinner.isHidden = true
                    progressLabel.isHidden = true
                }
            }
            
        }
    }

}

