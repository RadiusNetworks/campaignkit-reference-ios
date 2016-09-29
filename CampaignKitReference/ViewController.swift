//
//  ViewController.swift
//  CampaignKitReference
//
//  Created by Scott Newman on 9/28/16.
//  Copyright © 2016 Radius Networks. All rights reserved.
//

import UIKit
import CampaignKit
import UserNotifications

class ViewController: UIViewController {

  // MARK: - View Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Subscribe to notifications about found campaigns
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(campaignFound(notification:)),
                                           name: NSNotification.Name(rawValue: "CampaignFound"),
                                           object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Notification Handler
  
  func campaignFound(notification: NSNotification) {
    if let userInfo = notification.userInfo {
      if let campaign = userInfo["campaign"] as? CKCampaign {
        self.showAlertForCampaign(campaign)
      }
    }
  }

  // MARK: - User Interface Handling
  
  func showDeal(_ content: String?) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navVC = storyboard.instantiateViewController(withIdentifier: "DealNavController") as! UINavigationController
    let dealVC = navVC.childViewControllers.first as! DealViewController
    dealVC.htmlContent = content
    self.present(navVC, animated: true, completion: nil)
  }
  
  func showAlertForCampaign(_ campaign: CKCampaign) {
    
    let title = campaign.content.alertTitle
    let body = campaign.content.alertMessage
    let html = campaign.content.body
    
    let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
      self.showDeal(html)
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okayAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}
