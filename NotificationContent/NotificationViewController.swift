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
import SceneKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    var _inputViewController: UIViewController?
    var _inputView: UIView?
    
    override var inputView: UIView? {
        if _inputView != nil {
            return _inputView
        } else {
            return _inputViewController?.view
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let identifier = Identifier(rawValue: notification.request.identifier) else {
            return
        }

        switch identifier {
        case .stackView: setupStackView()
        case .mapKit: setupMapView()
        case .spriteKit: setupSKView()
        case .sceneKit: setupSCNView()
        case .inputView:
            setupInputView()
            becomeFirstResponder()
        case .spriteOnInput:
            setupSKViewOnInputView()
            becomeFirstResponder()
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
        case sceneKit
        case inputView
        case spriteOnInput
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
    
    func setupSCNView() {
        let gameVC = GameViewController()
        gameVC.view.translatesAutoresizingMaskIntoConstraints = false
        gameVC.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        addChild(gameVC)
        view.addSubview(gameVC.view)
        gameVC.didMove(toParent: self)
        setEdgesEqualTo(superView: view, view: gameVC.view)
    }
    
    func setupInputView() {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.addSubview(v)
        setEdgesEqualTo(superView: view, view: v)

        let vc = InputViewController()
        vc.tappedButtonHandler = {
            v.backgroundColor = (v.backgroundColor == .red) ? .white : .red
        }
        _inputViewController = vc
    }
    
    func setupSKViewOnInputView() {
        let lView = LabelView()
        view.addSubview(lView)
        setEdgesEqualTo(superView: view, view: lView)
        
        let skView = SKView()
        let scene = SKScene(fileNamed: "GameScene")! as! GameScene
        scene.touchDownHandler = { pos in
            lView.label.text = "x = \(pos.x)\ny = \(pos.y)"
            lView.label.textColor = .green
        }
        scene.touchMovedHandler = { pos in
            lView.label.text = "x = \(pos.x)\ny = \(pos.y)"
            lView.label.textColor = .blue
        }
        scene.touchUpHandler = { pos in
            lView.label.text = "x = \(pos.x)\ny = \(pos.y)"
            lView.label.textColor = .red
        }
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.translatesAutoresizingMaskIntoConstraints = false
        _inputView = skView
    }
    
    func setEdgesEqualTo(superView: UIView, view: UIView) {
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
    }
}
