//
//  UserModel.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/19.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

struct UserModel {
    
    var name: String
    var headImage: UIImage
    var privateHandwritings =  [Handwriting]()
    var commonHandwritings = [Handwriting]()
    var selectedHandwriting: Handwriting?
    
    init(name : String, headImage: UIImage = UIImage(named: "defaultHeadImage")!) {
        self.name = name
        self.headImage = headImage
    }
 
    
    static func defaultModel() -> UserModel {
        var model = UserModel(name: "cwift")
        let handwriting1 = Handwriting(image: UIImage(named: "测试字帖1")!)
        let handwriting2 = Handwriting(image: UIImage(named: "测试字帖2")!)
        model.commonHandwritings.append(handwriting1)
        model.commonHandwritings.append(handwriting2)
        model.selectedHandwriting = model.commonHandwritings.first!
        
        return model
    }
    
}
