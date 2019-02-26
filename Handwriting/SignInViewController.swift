//
//  SignInViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/10/19.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var telNumberLabel: UILabel!
    @IBOutlet weak var telNumberTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
    }
    
    private func setupNav() {
        let btn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        btn.title = "<返回"
        self.navigationItem.leftBarButtonItem = btn
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signInButton(_ sender: UIButton) {
        let user = UserDefaults.standard
        if telNumberTextField.text == "" || passwordTextField.text == ""{
            return
        }
        let tel = telNumberTextField.text
        let password = passwordTextField.text
        user.set(password, forKey: tel!)
        user.set(tel, forKey: "name")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        telNumberTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
}
