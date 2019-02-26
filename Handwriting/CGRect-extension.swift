//
//  CGRect-extension.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/5.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

extension CGRect {
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.init(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
    }
    
}
