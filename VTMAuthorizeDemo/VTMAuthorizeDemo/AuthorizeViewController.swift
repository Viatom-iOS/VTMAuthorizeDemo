//
//  AuthorizeViewController.swift
//  VTMAuthorizeDemo
//
//  Created by yangweichao on 2022/12/12.
//

import UIKit
import WebKit

class AuthorizeViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler, UIGestureRecognizerDelegate {
    
    
    
    var webView : WKWebView!
    var redirect = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.initSubviews()
        self.loadSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "goBack")
    }
    
    
    
    func initSubviews() {
        
        self.title = "ViHub登录"
        let webConfig = WKWebViewConfiguration()
        webConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        webConfig.userContentController = WKUserContentController()
        webConfig.userContentController.add(self, name: "goBack");
        
        webView = WKWebView.init(frame: self.view.bounds, configuration: webConfig)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        let backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: self, action:#selector(popToOriginal))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
    }

    
    func loadSource() {
        let request = URLRequest.init(url: URL(string: "http://193.169.0.227:8080")!)
        
        webView.load(request)
    }
    
    @objc func popToOriginal() {
        if redirect {
            webView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.name)
       
        if message.name == "goBack" {
            self.navigationController?.popViewController(animated: true)
        }
       
        
    }
    
    // MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        redirect = !redirect
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // MARK: UIGestureRecognizerDelegate
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        
//        return true
//    }

    
    
}
