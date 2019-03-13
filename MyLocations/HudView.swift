//
//  HudView.swift
//  MyLocations
//
//  Created by Artem Karmaz on 3/13/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class HudView: UIView {
    var text = ""
    
    class func hud(inView view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        hudView.isOpaque = false
        
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        
        hudView.backgroundColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 0.5)
        
        return hudView
    }
}
