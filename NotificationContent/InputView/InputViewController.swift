//
//  InputView.swift
//  NotificationContent
//
//  Created by sato-shin on 2019/05/13.
//  Copyright © 2019 Asken Inc. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    var tappedButtonHandler: (() -> Void)?
    
    @IBAction func tapped(_ sender: Any) {
        tappedButtonHandler?()
    }
}
