//
//  CommentEditViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/13.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

protocol CommentEditViewControllerDelegate: CommentViewControllerDelegate {
    func commentEditViewController(_ commentEditViewController: CommentEditViewController, _ commentModel: CommentModel)
}

class CommentEditViewController: CommentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    weak var editDelegate: CommentEditViewControllerDelegate?
    var indexPath: IndexPath!
    
    override func setupNav() {
        let leftBtn = UIBarButtonItem(title: "＜返回", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = leftBtn
        let rightBtn = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    override func setupTitleTextField() {
        super.setupTitleTextField()
        self.titleTextField.isEnabled = false
    }
    
    override func setupCommentTextView() {
        super.setupCommentTextView()
        self.commentTextView.isEditable = false
    }
    
    @objc func edit() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(save))
        titleTextField.isEnabled = true
        commentTextView.isEditable = true
    }
    
    override func save() {
        if titleTextField.text == "" {
            noTitleWarning()
        }
        model.title = titleTextField.text!
        model.comment = commentTextView.text
        self.editDelegate?.commentEditViewController(self, model)
        self.navigationController?.popViewController(animated: true)
    }
}
