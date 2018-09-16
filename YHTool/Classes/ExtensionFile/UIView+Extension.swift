//
//  UIView+Extension.swift
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - 裁剪所有圆角
    public func clipAllCorner(cornerRadius: CGFloat) {
        
        let maskPath = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    // MARK: - 指定角裁剪圆角
    public func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        
        let cornerSize = CGSize.init(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.masksToBounds = true
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.addSublayer(maskLayer)
        self.layer.mask = maskLayer
    }
    
    // MARK: - X
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    // MARK: - Y
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    // MARK: - Width
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    // MARK: - Height
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var tempFrame = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    // MARK: - centerX
    public var centerX: CGFloat {
        
        get {
            return center.x
        }
        set {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    // MARK: - centerY
    public var centerY: CGFloat {
        
        get {
            return center.y
        }
        set {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


















