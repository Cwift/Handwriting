//
//  HomeViewController.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/4.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var user = User.standard
    
    let comCellID = "comCellID"
    
    private var shapeLayer: CAShapeLayer!
    private var handwriting: Handwriting!
    private var imageView: UIImageView?
    
    private lazy var drawView: DrawView = {
        let frame = CGRect(x: 0, y: statusH + navigationH, width: screenW, height: bottomImageH + 50)
        let drawView = DrawView(frame: frame)
        drawView.isUserInteractionEnabled = false
        return drawView
    }()
    
    private lazy var maskingView: UIView = {
        let frame = self.bottomImageView.frame
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return view
    }()
    
    private lazy var bottomImageView: BottomImageView = {
        let bottomImageView = BottomImageView()
        bottomImageView.frame = CGRect(x: 0, y: statusH + navigationH, width: screenW, height: bottomImageH)
        return bottomImageView
    }()
    
    private lazy var rightBtn: UIBarButtonItem = {
        let rightBtn = UIBarButtonItem(title: "写注释", style: .plain, target: self, action: #selector(comment))
        return rightBtn
    }()
    
    private lazy var leftBtn: UIBarButtonItem = {
        let leftBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelComment))
        return leftBtn
    }()
    
    private lazy var commentTableView: UITableView = {
        let tbvFrame = CGRect(x: 0, y: statusH + navigationH + bottomImageH, width: screenW, height: commentTableH)
        let comTV = UITableView(frame: tbvFrame)
        comTV.dataSource = self
        comTV.delegate = self
        comTV.backgroundColor = UIColor.blue
        comTV.isPagingEnabled = true
        comTV.showsHorizontalScrollIndicator = false
        comTV.separatorStyle = .none
        comTV.allowsMultipleSelection = true
        
        return comTV
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.handwriting = user.selectedHandwriting
        self.bottomImageView.image = self.handwriting.image
        self.commentTableView.reloadData()
    }
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getModel()
        loadHandwriting()
        setupBottomImage()
        
        setupNavigation()
        setupTableView()
        setupDrawView()
    }
    
    func getModel() {
    
    }
    
    func loadHandwriting() {
        self.handwriting = user.selectedHandwriting
    }
    
    private func setupBottomImage() {
        bottomImageView.image = handwriting.image
//        bottomImageView.contentMode = .scaleAspectFill
        self.view.addSubview(bottomImageView)
        
    }
    
    private func setupNavigation() {
        self.navigationItem.title = handwriting.title
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupDrawView() {
        self.view.addSubview(drawView)
        drawView.delegate = self
    }
    
    private func setupTableView() {
        let cellNIB = UINib(nibName: CommentCell.identifier, bundle: nil)
        commentTableView.register(cellNIB, forCellReuseIdentifier: comCellID)
        
        self.view.addSubview(commentTableView)
    }
    
    @objc func comment() {
        drawView.isUserInteractionEnabled = true
        self.maskingView.removeFromSuperview()
        self.imageView?.removeFromSuperview()
        self.shapeLayer?.removeFromSuperlayer()
        self.navigationItem.leftBarButtonItem = leftBtn
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func cancelComment() {
        drawView.isUserInteractionEnabled = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = rightBtn
        drawView.shapeLayer?.removeFromSuperlayer()
        drawView.OKBtn.isHidden = true
        drawView.NOBtn.isHidden = true
    }
    
//    func saveEdit() {
//        myUserDefaults.standardUser.model = self.model
//    }
    
}

//  用户设置完注释区域后跳转至注释页面
extension HomeViewController: DrawViewDelegate {
    func drawView(_ drawViewController: DrawView, _ shapeLayer: CAShapeLayer, _ rect: CGRect) {
        self.shapeLayer = shapeLayer
        cancelComment()
        let image = bottomImageView.subImage(rect: rect) ?? UIImage(named: "defaultImage")!
        let commentModel = CommentModel(image: image, title: "注释 \(String(self.handwriting.commentModels.count + 1))", comment: nil, layer: shapeLayer)
        let commentVC = UIStoryboard(name: CommentViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CommentViewController.identifier) as! CommentViewController
        
        commentVC.model = commentModel
        commentVC.delegate = self
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}

//  在注释页面保存之后返回数据给主页面
extension HomeViewController: CommentViewControllerDelegate {
    func commentViewController(_ commentViewComtroller: CommentViewController, _ commentModel: CommentModel) {
        handwriting.commentModels.append(commentModel)
        commentTableView.reloadData()
        let newIndexPath = IndexPath(row: handwriting.commentModels.count - 1, section: 0)
        commentTableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
//        saveEdit()
    }
}

//  设置tableView的cell
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handwriting.commentModels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: comCellID) as! CommentCell
        let commentModel = handwriting.commentModels[indexPath.item]
        cell.numberLabel.text = String(indexPath.item + 1)
        cell.commentImageView.image = commentModel.image
        cell.commentTitleLabel.text = commentModel.title
        cell.commentModel = commentModel
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //  用户点击tableView之后图像出现蒙版突出功能
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shapeLayer?.removeFromSuperlayer()
        imageView?.removeFromSuperview()
        let model = handwriting.commentModels[indexPath.item]
        shapeLayer = model.layer!
        var rect = (shapeLayer.path?.boundingBox)!
        let image = self.bottomImageView.subImage(rect: rect)
        rect.origin.y += 64  //相对于navigation偏移
        self.imageView = UIImageView(frame: rect)
        self.imageView?.image = image
        self.view.addSubview(maskingView)
        self.view.addSubview(imageView!)
        self.drawView.layer.addSublayer(shapeLayer)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        shapeLayer.removeFromSuperlayer()
        maskingView.removeFromSuperview()
        imageView?.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            handwriting.commentModels.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

//  cell中的button被按下
extension HomeViewController: CommentCellDelegate {
    func commentCell(_ commentCell: CommentCell, _ commentModel: CommentModel) {
        let commentVC = UIStoryboard(name: CommentEditViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CommentEditViewController.identifier) as! CommentEditViewController
        
        commentVC.model = commentModel
        commentVC.indexPath = commentCell.indexPath
        commentVC.editDelegate = self
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}

// 用户修改某一个注释
extension HomeViewController: CommentEditViewControllerDelegate {
    func commentEditViewController(_ commentEditViewController: CommentEditViewController, _ commentModel: CommentModel) {
        let model = commentModel
        let indexPath = commentEditViewController.indexPath!
        handwriting.commentModels[indexPath.item] = model
        let cell = commentTableView.cellForRow(at: indexPath) as! CommentCell
        cell.commentModel = model
        commentTableView.reloadData()
//        saveEdit()
    }
}
