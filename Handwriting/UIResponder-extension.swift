//
//  UIResponder-extension.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/11.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier: String {
        return String(describing: self)
    }
}
