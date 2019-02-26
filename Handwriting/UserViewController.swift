//
//  UserViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/4.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

let comCellID = "comCellID"

class UserViewController: UIViewController {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var levelOneTableView: UITableView!
    
    var user = User.standard
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setupNav()
        setupHeadImageView()
        setupUserNameLabel()
        setupTableView()
    }
    
    func setupNav() {
        
    }
    
    func setupHeadImageView() {
        headImageView.image = user.headImage
        headImageView.layer.cornerRadius = 25
        headImageView.clipsToBounds = true
    }
    
    func setupUserNameLabel() {
        userNameLabel.text = user.name
    }
    
    func setupTableView() {
        levelOneTableView.register(UITableViewCell.self, forCellReuseIdentifier: comCellID)
        let cellNIB = UINib(nibName: levelCell.identifier, bundle: nil)
        levelOneTableView.register(cellNIB, forCellReuseIdentifier: comCellID)
        levelOneTableView.separatorStyle = .none
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: "uuid")
        self.dismiss(animated: true)
    }
    
}

//  tableView相关
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: comCellID, for: indexPath) as! levelCell
        cell.nameLabel.text = "公共字帖"
        let count = user.commonHandwritings.count
        cell.countLabel.text = "\(count) >"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    // 选择字帖时跳转至字帖选择vc
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HandwritingChooseViewController()
        vc.handwritings = user.commonHandwritings
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        
    }
    
}

extension UserViewController: HandwritingChooseViewControllerDelegate {
    func handwritingChooseViewController(_ handwritingChooseViewController: HandwritingChooseViewController, didSelectHandwriting handwriting: Handwriting) {
//        let handData = NSKeyedArchiver.archivedData(withRootObject: handwriting)
//        user.set(handData, forKey: "selectedHandwritingData")
        user.selectedHandwriting = handwriting
        self.tabBarController?.selectedIndex = 0
        
    }
}
