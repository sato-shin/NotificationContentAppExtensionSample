//
//  ViewController.swift
//  NotificationTest
//
//  Created by sato-shin on 2019/04/15.
//  Copyright © 2019 Asken Inc. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBAction func touchUpButton1(_ sender: Any) {
        // action
        let category = UNNotificationCategory(identifier: "myNotificationCategory",
                                              actions: [],
                                              intentIdentifiers: [],
                                              hiddenPreviewsBodyPlaceholder: "placeholder",
                                              options: [.hiddenPreviewsShowSubtitle, .hiddenPreviewsShowTitle])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // content
        let content = UNMutableNotificationContent()
        content.body = "Dynamic height with StackView"
        content.categoryIdentifier = "myNotificationCategory"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: "request", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}