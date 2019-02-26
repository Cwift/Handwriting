//
//  Handwriting.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/17.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class Handwriting{

    var image: UIImage
    var commentModels: [CommentModel]
    var title: String?
    var author: String?
    var style: String?
    
    init(image : UIImage, title: String? = nil,author: String? = nil, models: [CommentModel] = [CommentModel]()) {
        self.image = image
        self.commentModels = models
        self.title = title
        self.author = author
    }
    
}
