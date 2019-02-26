//
//  CommentViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/6.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

protocol CommentViewControllerDelegate: class {
    func commentViewController(_ commentViewComtroller: CommentViewController, _ commentModel: CommentModel)
}

class CommentViewController: UIViewController {
    
    var image: UIImage!
    var model: CommentModel!
    
    @IBOutlet weak var titleTextField: UITextField! 
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var comImageView: UIImageView!
    
    weak var delegate: CommentViewControllerDelegate?
    
    private lazy var maskingView: UIView = {
        let frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
//        self.view = UIImageView(image: UIImage(named: "commentBackground"))
        setupNav()
        
        setupComImageView()
        setupTitleTextField()
        setupCommentTextView()
        
        hidesBottomBarWhenPushed = true
        
    }
    
    
    func setupComImageView() {
        self.comImageView.image = model.image
        
        self.view.addSubview(comImageView)
    }
    
    func setupNav() {
        let leftBtn = UIBarButtonItem(title: "＜返回", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = leftBtn
        let rightBtn = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save() {
        if titleTextField.text == "" {
            self.view.addSubview(maskingView)
            noTitleWarning()
            self.maskingView.removeFromSuperview()
            return
        }
        model.title = titleTextField.text!
        model.comment = commentTextView.text
        self.delegate?.commentViewController(self, model)
        self.navigationController?.popViewController(animated: true)
    }
    
    func noTitleWarning() {
        let alert = UIAlertController(title: "标题不能为空", message: "点击确定将标题恢复为默认标题", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "确定", style: .default) { _ in
            self.titleTextField.text = self.model?.title
        }
        let NOAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        alert.addAction(OKAction)
        alert.addAction(NOAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupTitleTextField() {
        titleTextField.backgroundColor = UIColor.white
        titleTextField.tintColor = UIColor.black
        titleTextField.text = model?.title
        
        self.view.addSubview(titleTextField)
    }
    
    func setupCommentTextView() {
        commentTextView.text = model?.comment
        
        self.view.addSubview(commentTextView)
    }
    
}
