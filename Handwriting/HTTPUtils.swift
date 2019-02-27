//
//  HTTPUtils.swift
//  Handwriting
//
//  Created by 酱油 on 2019/2/27.
//  Copyright © 2019 jiangyou. All rights reserved.
//

import Alamofire

func login(username: String, password: String) -> Bool {
    var params = [String: String]()
    params["username"] = username
    params["password"] = password
    
    Alamofire.request("http://192.168.211.1/test/login", method: .get, parameters: params)
        .responseData(completionHandler: ({ (response) in
            print(response.request!)
            print(response.response!)
            print(response.result)
        }))
    return false
}
