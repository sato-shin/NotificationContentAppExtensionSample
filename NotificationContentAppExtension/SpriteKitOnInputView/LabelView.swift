//
//  LabelView.swift
//  NotificationContent
//
//  Created by sato-shin on 2019/05/14.
//  Copyright © 2019 Asken Inc. All rights reserved.
//

import UIKit

class LabelView: UIView {
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibInit()
    }
    
    private func nibInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LabelView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
    }
}
