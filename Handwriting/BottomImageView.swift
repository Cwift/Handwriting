//
//  BottomView.swift
//  Handwriting
//
//  Created by jiangyou on 2017/8/4.
//  Copyright © 2017年 jiangyou. All rights reserved.
//

import UIKit

class BottomImageView: UIImageView {

    func subImage(rect: CGRect) -> UIImage? {
        let sourceImage: CGImage = (self.image?.cgImage!)!
        let widthScale = CGFloat(sourceImage.width) / self.frame.width
        let heightScale = CGFloat(sourceImage.height) / self.frame.height
        let originPoint = CGPoint(x: rect.origin.x * widthScale, y: rect.origin.y * heightScale)
        let size = CGSize(width: rect.width * widthScale, height: rect.height * heightScale)
        let rect = CGRect(origin: originPoint, size: size)
        let image = sourceImage.cropping(to: rect)
        
        return image == nil ? nil : UIImage(cgImage: image!)
    }
    
}
