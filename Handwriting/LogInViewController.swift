//
//  LogInViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/20.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    let user = UserDefaults.standard
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logInButton(_ sender: UIButton) {
        if nameTextField.text == "" {
            return
        }
        if passwordTextField.text == "" {
            return
        }
        let user = UserDefaults.standard
        let name = nameTextField.text
        let psd = passwordTextField.text
        if let password = user.string(forKey: name!) {
            if psd == password {
                let uuid = UUID().uuidString
                user.set(uuid, forKey: "uuid")
                isLoged()
            }
        }
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
    
    }
    
    @IBAction func forgetButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.nameTextField.placeholder = "用户名"
        self.passwordTextField.placeholder = "密码"
        self.passwordTextField.isSecureTextEntry = true
    }

    override func viewDidAppear(_ animated: Bool) {
        isLoged()
    }
    
    func isLoged() {
        if user.string(forKey: "uuid") != nil {
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UITabBarController
            self.present(mainVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func testAccount(_ sender: UIButton) {
        user.set("cwift", forKey: "name")
        let uuid = UUID().uuidString
        user.set(uuid, forKey: "uuid")
        isLoged()
        
    }

}
