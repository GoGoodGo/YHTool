//
//  YHTextField.swift
//  E_Business
//
//  Created by YH_O on 2017/4/24.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

public class YHTextField: UITextField {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func becomeFirstResponder() -> Bool {
        
        layer.borderColor = MainColor.cgColor
        setValue(UIColor.lightGray, forKeyPath: "_placeholderLabel.textColor")
        return super.becomeFirstResponder()
    }
    
    override public func resignFirstResponder() -> Bool {
        
        layer.borderColor = UIColor.lightGray.cgColor
        setValue(UIColor.darkGray, forKeyPath: "_placeholderLabel.textColor")
        return super.resignFirstResponder()
    }
    
    // MARK: - PrivateMethod
    private func setupSubviews() {
        
        tintColor = .black
        layer.borderColor = UIColor.lightGray.cgColor
        leftViewMode = .always
        leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: self.height))
    }
    
    // MARK: - Setter
    override public func drawPlaceholder(in rect: CGRect) {
        
        var tempRect = rect
        tempRect.origin.y += (self.font?.pointSize)! - fontSize
        super.drawPlaceholder(in: tempRect)
    }
    
    public var fontSize: CGFloat = 14 {
        didSet {
            self.setValue(UIFont.systemFont(ofSize: fontSize), forKeyPath: "_placeholderLabel.font")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
