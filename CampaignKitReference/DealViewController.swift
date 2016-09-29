//
//  DealViewController.swift
//  CampaignKitReference
//
//  Created by Scott Newman on 9/28/16.
//  Copyright © 2016 Radius Networks. All rights reserved.
//

import UIKit

class DealViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  var htmlContent:String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let html = htmlContent {
      self.webView.loadHTMLString(html, baseURL: nil)
    }
    
  }

  @IBAction func didPressDone(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }

}
