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
    @IBAction func touchUpStackViewButton(_ sender: Any) {
        sendNotification(body: "Dynamic height with StackView", identifier: "stackView")
    }
    
    @IBAction func touchUpMapButton(_ sender: Any) {
        sendNotification(body: "Map", identifier: "mapKit")
    }
    
    @IBAction func touchUpSpriteKitButton(_ sender: Any) {
        sendNotification(body: "SpriteKit", identifier: "spriteKit")
    }
    
    @IBAction func touchupSceneKitButton(_ sender: Any) {
        sendNotification(body: "SceneKit", identifier: "sceneKit")
    }
    
    @IBAction func touchupInputViewButton(_ sender: Any) {
        sendNotification(body: "InputView", identifier: "inputView")
    }
    
    func sendNotification(body: String, identifier: String) {
        // action
        let category = UNNotificationCategory(identifier: "myNotificationCategory",
                                              actions: [],
                                              intentIdentifiers: [],
                                              hiddenPreviewsBodyPlaceholder: "placeholder",
                                              options: [.hiddenPreviewsShowSubtitle, .hiddenPreviewsShowTitle])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // content
        let content = UNMutableNotificationContent()
        content.body = body
        content.categoryIdentifier = "myNotificationCategory"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
