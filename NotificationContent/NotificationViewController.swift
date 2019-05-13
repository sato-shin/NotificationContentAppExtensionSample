//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by sato-shin on 2019/04/16.
//  Copyright © 2019 Asken Inc. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        (0..<5).forEach { i in
            let v = ItemView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
            v.label.text = "Item \(i)"
            stackView.addArrangedSubview(v)
        }
    }
    
    func didReceive(_ notification: UNNotification) {
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
    }
}
