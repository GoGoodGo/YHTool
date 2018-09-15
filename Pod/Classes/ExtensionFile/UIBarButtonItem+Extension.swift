//
//  UIBarButtonItem+Extension.swift
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    public class func item(image: String? = nil, highligtImage: String? = nil, title: String? = nil, titleColor: UIColor? = .white, target: Any?, action: Selector) -> UIBarButtonItem {
        
        let btn = UIButton.init(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(UIImage.init(named: image ?? ""), for: .normal)
        btn.setImage(UIImage.init(named: highligtImage ?? ""), for: .highlighted)
        
        var frame = btn.frame
        frame.size.width = (btn.currentImage?.size.width) ?? 0 + (NSString.init(string: title ?? "").size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]).width) + 20
        frame.size.height = (btn.currentImage?.size.height) ?? 44
        btn.frame = frame
        
        return UIBarButtonItem.init(customView: btn)
    }
}



















