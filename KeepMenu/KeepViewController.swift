//
//  KeepViewController.swift
//  KeepMenu
//
//  Created by Sidhant Gandhi on 4/10/20.
//  Copyright © 2020 newnoetic. All rights reserved.
//

import Cocoa
import WebKit

class KeepViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.preferredContentSize = NSSize(width: 650, height: 700)
        
        let url = URL(string: "https://keep.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
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
