//
//  AppDelegate.swift
//  CampaignKitReference
//
//  Created by Scott Newman on 9/28/16.
//  Copyright © 2016 Radius Networks. All rights reserved.
//

import UIKit
import CampaignKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var campaignKitManager: CKManager!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Ask for authorization to present local notifications
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
    }

    // Don't background fetch more than every 15 minutes
    application.setMinimumBackgroundFetchInterval(15 * 60)
    
    // Create and start the Campaign Kit Manager
    let configDict: [String:Any] = [
      "CKAPIToken": "0af5010ba6f846855b90cdabdf5cee5376c380c296855be312efb708352ac94f",
      "CKKitURL": "https://campaignkit.radiusnetworks.com/sdk/v1/kits/1104",
      "PKAPIToken": "fa09e46f35158a6a09b489a4fadde84590c33c0eb019976e6e100c931db49adf",
      "PKKitURL": "https://proximitykit.radiusnetworks.com/api/kits/7777",
    ]
    
    // Create and start the Campaign Kit Manager
    if let manager = CKManager(delegate:self, andConfig:configDict) {
      self.campaignKitManager = manager
      self.campaignKitManager.start()
    }
    
    return true
  }

  // Use Background Fetch to Sync Campaign Kit
  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("Syncing Campaign Kit in the Background")
    self.campaignKitManager.sync(completionHandler: completionHandler)
  }
  
}

// MARK: - User Notifications

func createAndSendNotification(title:String, body:String) {
  
  let content = UNMutableNotificationContent()
  
  content.title = title
  content.body = body
  content.sound = UNNotificationSound.default()
  content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
  content.categoryIdentifier = "com.radiusnetworks.localNotification"
  
  let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.25, repeats: false)
  let request = UNNotificationRequest.init(identifier: "CKNotification", content: content, trigger: trigger)

  let center = UNUserNotificationCenter.current()
  center.add(request)
  
  print("Added request")
}

// MARK: - Campaign Kit Delegate Methods

extension AppDelegate : CKManagerDelegate {
  
  func campaignKit(_ manager: CKManager!, didDetect place: CKPlace!, on event: CKEventType) {
    //print("Did detect place")
  }
  
  func campaignKit(_ manager: CKManager!, didFailWithError error: Error!) {
    //print("Did fail with error: \(error)")
  }
  
  func campaignKitDidSync(_ manager: CKManager!) {
    //print("Did sync Campaign Kit")
  }
  
  func campaignKit(_ manager: CKManager!, didFind campaign: CKCampaign!) {

    print("Found Campaign")
    
    // If the app is not active, show a local notification
    if UIApplication.shared.applicationState != .active {
      print("Showing Local Notification")
      let body = campaign.content.alertTitle.replacingOccurrences(of: "%", with: "%%")
      createAndSendNotification(title: "View Details", body: body)
    }
    else {
      print("Posting Notification Center Message")
      let userInfo = ["campaign": campaign!]
      let name = Notification.Name(rawValue: "CampaignFound")
      let notification = Notification(name: name, object: self, userInfo: userInfo)
      NotificationCenter.default.post(notification)
    }

  }
  
}
