//
//  HandwritingChooseViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/18.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

let cellID = "chooseCellD"

protocol HandwritingChooseViewControllerDelegate: class {
    func handwritingChooseViewController(_ handwritingChooseViewController: HandwritingChooseViewController, didSelectHandwriting handwriting: Handwriting)
}

class HandwritingChooseViewController: UIViewController {

    var handwritings: [Handwriting]!
    weak var delegate: HandwritingChooseViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let height = screenH - statusH - navigationH
        let frame = CGRect(x: 0, y: 0, width: screenW, height: height)
        let tableView = UITableView(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hidesBottomBarWhenPushed = true
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        setupNavigation()
    }

    func setupNavigation() {
        let btn = UIBarButtonItem(title: "＜返回", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = btn
    }
    
    @objc func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HandwritingChooseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handwritings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name = handwritings[indexPath.item].title
        
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.handwritingChooseViewController(self, didSelectHandwriting: handwritings[indexPath.item])
        self.navigationController?.popViewController(animated: true)
    }
    
}
