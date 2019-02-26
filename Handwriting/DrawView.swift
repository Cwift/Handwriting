//
//  DrawView.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/5.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

protocol DrawViewDelegate: class {
    func drawView(_ drawViewController: DrawView, _ shapeLayer: CAShapeLayer, _ rect: CGRect)
}

class DrawView: UIView {

    var startPoint: CGPoint!
    var endPoint: CGPoint!
    
    var shapeLayer: CAShapeLayer!
    
    weak var delegate: DrawViewDelegate?
    
    lazy var OKBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0,y: bottomImageH, width: screenW / 2, height: commentTableH)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("确定", for: .normal)
        btn.addTarget(self, action: #selector(OKAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    @objc func OKAction() {
        delegate?.drawView(self, shapeLayer, CGRect(startPoint: startPoint, endPoint: endPoint))
        shapeLayer.removeFromSuperlayer()
        hideBtn()
    }
    
    lazy var NOBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: screenW / 2,y: bottomImageH, width: screenW / 2, height: commentTableH)
        btn.backgroundColor = UIColor.red
        btn.setTitle("取消", for: .normal)
        btn.addTarget(self, action: #selector(NOAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    @objc func NOAction() {
        shapeLayer.removeFromSuperlayer()
        hideBtn()
    }
    
    func hideBtn() {
        OKBtn.isHidden = true
        NOBtn.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(OKBtn)
        self.addSubview(NOBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            shapeLayer?.removeFromSuperlayer()
            shapeLayer = CAShapeLayer.defaultShapeLayer()
            startPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endPoint = touch.location(in: self)
            endPoint.y = endPoint.y < 0 ? 0 : endPoint.y
            endPoint.y = endPoint.y > bottomImageH ? bottomImageH : endPoint.y
            shapeLayer.path = UIBezierPath(rect: CGRect(startPoint: startPoint, endPoint: endPoint)).cgPath
            self.layer.addSublayer(shapeLayer)
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        OKBtn.isHidden = false
        NOBtn.isHidden = false
    }

}
