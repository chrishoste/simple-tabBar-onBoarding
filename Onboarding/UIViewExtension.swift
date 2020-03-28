//
//  UIViewExtension.swift
//  Onboarding
//
//  Created by Christophe Hoste on 28.03.20.
//  Copyright © 2020 Christophe Hoste. All rights reserved.
//

import UIKit

extension UIView {
    
    func cutHole(atRect: CGRect) {
        
        guard let superview = superview else {
            return
        }
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        // Create the frame for the circle.
        // Rectangle in which circle will be drawn
        let rectPath = UIBezierPath(roundedRect: atRect, cornerRadius: 10)
        // Create a path
        //let path = UIBezierPath(rect: view.bounds)
        let path = UIBezierPath(roundedRect: superview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: .init(width: 30, height: 30))
        // Append additional path which will create a circle
        path.append(rectPath)
        // Setup the fill rule to EvenOdd to properly mask the specified area and make a crater
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        // Append the circle to the path so that it is subtracted.
        maskLayer.path = path.cgPath
        // Mask our view with Blue background so that portion of red background is visible
        layer.mask = maskLayer
    }
}
