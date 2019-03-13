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
        
        hudView.show(animated: animated)
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
        
        // Draw checkmark
        if let image = UIImage(named: "Checkmark") {
            let imaePoint = CGPoint (
                x: center.x - round(image.size.width / 2),
                y: center.y - round(image.size.height / 2) - boxHeight / 8)
            image.draw(at: imaePoint)
        }
        
        // Draw the text
        let attribs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let textSize = text.size(withAttributes: attribs)
        
        let textPoint = CGPoint(
            x: center.x - round(textSize.width / 2),
            y: center.y - round(textSize.height / 2) + boxHeight / 4)
        
        text.draw(at: textPoint, withAttributes: attribs)
    }
    
    // MARK: Public Methods
    
    func show(animated: Bool) {
        if animated {
            alpha = 0
            transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.alpha = 1
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
