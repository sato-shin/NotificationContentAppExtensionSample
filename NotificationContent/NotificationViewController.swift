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
import MapKit
import SpriteKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    func didReceive(_ notification: UNNotification) {
        guard let identifier = Identifier(rawValue: notification.request.identifier) else {
            return
        }
        
        switch identifier {
        case .stackView: setupStackView()
        case .mapKit: setupMapView()
        case .spriteKit: setupSKView()
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
    }
}

extension NotificationViewController {
    enum Identifier: String {
        case stackView
        case mapKit
        case spriteKit
    }
    
    func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        setEdgesEqualTo(superView: view, view: stackView)

        (0..<5).forEach { i in
            let v = ItemView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
            v.label.text = "Item \(i)"
            stackView.addArrangedSubview(v)
        }
    }
    
    func setupMapView() {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.addSubview(mapView)
        setEdgesEqualTo(superView: view, view: mapView)
    }
    
    func setupSKView() {
        let skView = SKView()
        let scene = SKScene(fileNamed: "GameScene")!
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.addSubview(skView)
        setEdgesEqualTo(superView: view, view: skView)
    }
    
    func setEdgesEqualTo(superView: UIView, view: UIView) {
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
    }
}
