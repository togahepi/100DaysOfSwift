//
//  ViewController.swift
//  Project4
//
//  Created by user197801 on 5/11/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["hackingwithswift.com", "genk.vn", "apple.com", "google.com", "dantri.com.vn"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this line just add a button on navigation bar that show a menu of Open things
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //from this line we creat website view with default is the first in websites array
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))                  //webview can not directly load from URL, it need go to through URLResqurest
        webView.allowsBackForwardNavigationGestures = true
        
        //from this line below we creat a toolbar that hold progress of loading page and a refresh button
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .done, target: webView, action: #selector(webView.goBack))
//        let forward = UIBarButtonItem(barButtonSystemItem: .done, target: webView, action: #selector(webView.goForward))
        let forward = UIBarButtonItem(title: "Next", style: .done, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .bar)
//        progressView.progressTintColor = UIColor.orange
        //.bar will not pre-draw a full gray of progress, why .default will have a pre-draw 100% gray one
        //progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)   //in oder to load progress we need observe webview with this
        
        toolbarItems = [progressButton, spacer, refresh, back, forward]
        navigationController?.isToolbarHidden = false   //end of toolbar things
        
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem    //this line for ipad only
        present(ac, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            
            if progressView.progress <= 0.3 {
                progressView.progressTintColor = UIColor.red
            } else if progressView.progress <= 0.7 {
                progressView.progressTintColor = UIColor.yellow
            } else {
                progressView.progressTintColor = UIColor.systemBlue
            }
        }
    }
    
    //this func will check weather the link we click contain domain of our pre-listed website or not, if not it will cancel the link we want to go
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url
//        var count = 0
//            if let host = url?.host {
//                print(host)
//                for website in websites {
//                    if (host.contains(website)){
//                        decisionHandler(.allow)
//                        return
//                    }
//                }
//                let alert = UIAlertController(title: "Stop", message: "This link is forbidden! Go back!", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                present(alert, animated: true)
//            }
//        count += 1
//        print(count)
//
//            decisionHandler(.cancel)
//
//
//    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if navigationResponse.isForMainFrame {
            let url = navigationResponse.response.url
            print(url!)
            var count = 0
            if let host = url?.host {
                print(host)
                
                for website in websites {
                    count += 1
                    print(count)
                    if (host.contains(website)) {
                        decisionHandler(.allow)
                        return
                    }
                }
                
                let alert = UIAlertController(title: "Stop", message: "This link is forbidden! Go back!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                present(alert, animated: true)
            }
            
        }
        
        decisionHandler(.cancel)
    }
    

}

