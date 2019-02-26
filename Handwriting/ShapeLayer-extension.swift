//
//  ShapeLayer-extension.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/6.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    
    class func defaultShapeLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let frame = CGRect(x: 0, y: 0, width: screenW, height: bottomImageH)
        shapeLayer.frame = frame
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        
        return shapeLayer
    }
    
}
