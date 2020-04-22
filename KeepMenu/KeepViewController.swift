//
//  KeepViewController.swift
//  KeepMenu
//
//  Created by Sidhant Gandhi on 4/10/20.
//  Copyright © 2020 newnoetic. All rights reserved.
//

import Cocoa
import WebKit
import WebKitUrlFix

class KeepViewController: NSViewController {

    weak var parentPopover: NSPopover?
    @IBOutlet weak var webView: WKWebView!
    var webKitFix: WebKitUrlFixer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        webKitFix = WebKitUrlFixer(forwardDelegate: self)
        
        webView.navigationDelegate = webKitFix
        webView.uiDelegate = webKitFix

        self.preferredContentSize = NSSize(width: 650, height: 700)
        
        let url = URL(string: "https://keep.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension KeepViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("close popup on link click")
        self.parentPopover?.close()
        return nil
    }
}

extension KeepViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> KeepViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("KeepViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? KeepViewController else {
      fatalError("Why cant i find KeepViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
