//
//  WebKitViewController.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import UIKit
import WebKit


class ModalViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url = "https://ya.ru"
    
    override func loadView() {
        
        let contentController = WKUserContentController()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        webConfiguration.allowsInlineMediaPlayback = true
        //webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
        
        if #available(iOS 10.0, *) {
            webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        } else {
            // Fallback on earlier versions
            webConfiguration.mediaPlaybackRequiresUserAction = false
        }
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsLinkPreview = true
        webView.scrollView.bounces = false
        //webView.translatesAutoresizingMaskIntoConstraints = false
        //webView.scrollView.isScrollEnabled = false
        //webView.scrollView.panGestureRecognizer.isEnabled = false
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        view = webView
        
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("Button Clicked!")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView.load(URLRequest(url: URL(string: url )!))
        
        let button = MyButoon()
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func MyButoon() -> UIButton {
        let radius: CGFloat = 50
        let x = UIScreen.main.bounds.width - radius
        let y = UIScreen.main.bounds.height - radius
        print(x,y)
        let button = UIButton();
        //button.setTitle("Add", for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: x, y: y, width: radius*2, height: radius*2)
        button.backgroundColor = UIColor.withAlphaComponent(UIColor.white)(0.5);
        button.layer.cornerRadius = radius;
        return button
    }
    
    // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // Объявление алерта
    
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            webView.load(navigationAction.request)
            print("Open it locally: ", navigationAction.request.url!)
            decisionHandler(.allow)
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if self.view.window == nil {
            self.setValue(nil, forKey: "view")
        }
    }
    
}
