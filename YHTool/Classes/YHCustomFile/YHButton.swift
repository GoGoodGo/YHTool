//
//  YHButton.swift
//  E_User
//
//  Created by YH_O on 2017/5/16.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

public enum BtnLayouType {
    case ImgTopTitleBottomMode
    case ImgRightTitleLeftMode
}

public class YHButton: UIButton {
    
    public var btnLayout = BtnLayouType.ImgTopTitleBottomMode

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    // MARK: - PrivateMethod
    private func setupSubviews() {

        if btnLayout == BtnLayouType.ImgTopTitleBottomMode {
            imageView?.centerX = self.width / 2
            imageView?.y = 5
            
            titleLabel?.x = 0
            titleLabel?.y = (self.imageView?.frame.maxY)!
            titleLabel?.width = self.width
            titleLabel?.height = self.height - (self.titleLabel?.y)!
        } else {
            titleLabel?.x -= 10
            imageView?.x = (titleLabel?.frame.maxX)! + 5
        }
    }
    
    private func setup() {
        
        titleLabel?.textAlignment = .center
    }
    
    
    
    
    
    
    
    
    
    
    

}

