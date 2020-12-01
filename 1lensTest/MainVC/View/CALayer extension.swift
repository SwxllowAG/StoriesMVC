//
//  HelperButtons.swift
//  1lensTest
//
//  Created by Galym Anuarbek on 2/12/20.
//  Copyright © 2020 Galym Anuarbek. All rights reserved.
//

import UIKit

extension CALayer {
    func addGradienBorder(colors:[UIColor],width:CGFloat = 1) {
        self.masksToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = colors.map({$0.cgColor})

        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        let arcCenter = CGPoint(x: self.bounds.origin.x + self.bounds.width/2, y: self.bounds.origin.y + self.bounds.height/2)
        shapeLayer.path = UIBezierPath(arcCenter: arcCenter, radius: (self.bounds.width - 2)/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer

        self.addSublayer(gradientLayer)
    }
}
