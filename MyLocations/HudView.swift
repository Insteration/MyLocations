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
    
    
    // Основная цель этого метода - создать экземпляр представления HUD, чтобы вам не пришлось делать это самостоятельно, и поместить его поверх другого представления.
    // В конце метода новый экземпляр возвращается вызывающей стороне.
    
    class func hud(inView view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        hudView.isOpaque = false
        
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        
//        hudView.backgroundColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 0.5)
        
        return hudView
    }
    
    
    // «Метод draw () вызывается всякий раз, когда UIKit хочет, чтобы ваш вид перерисовал сам себя.
    
    override func draw(_ rect: CGRect) {
        let boxWidth: CGFloat = 96
        let boxHeight: CGFloat = 96
        
        let boxRect = CGRect (
            x: round((bounds.size.width - boxWidth) / 2),
            y: round((bounds.size.height - boxHeight) / 2),
            width: boxWidth,
            height: boxHeight)
        
        let roundRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        UIColor(white: 0.3, alpha: 0.8).setFill()
        roundRect.fill()
        
    }
}
