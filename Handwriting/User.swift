//
//  UserModel.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/17.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class User {
    
    var headImage: UIImage = UIImage(named: "defaultHeadImage")!
    var name: String
    var privateHandwritings = [Handwriting]()
    var commonHandwritings = [Handwriting]()
    var selectedHandwriting: Handwriting?
    
    private init(name: String) {
        self.name = name
    }
    
    static var standard: User = {
        var user = User(name: "cwift")
        let handwriting1 = Handwriting(image: UIImage(named: "测试字帖1")!)
        handwriting1.title = "公共字帖1"
        let handwriting2 = Handwriting(image: UIImage(named: "测试字帖2")!)
        handwriting2.title = "公共字帖2"
        let handwriting3 = Handwriting(image: UIImage(named: "兰亭集序")!)
        handwriting3.title = "兰亭集序"
        user.commonHandwritings.append(handwriting1)
        user.commonHandwritings.append(handwriting2)
        user.commonHandwritings.append(handwriting3)
        user.selectedHandwriting = user.commonHandwritings.first
        
        return user
    }()
    

}
