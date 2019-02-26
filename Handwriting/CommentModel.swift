//
//  CommentModel.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/10.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

struct CommentModel {
    
    var image: UIImage
    var title: String
    var comment: String?
    var layer: CAShapeLayer?
    
    init(image: UIImage, title: String, comment: String?, layer: CAShapeLayer? = nil) {
        self.image = image
        self.title = title
        self.comment = comment
        self.layer = layer
    }
    
}
