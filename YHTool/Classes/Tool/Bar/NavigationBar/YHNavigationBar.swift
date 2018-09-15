//
//  YHNavigationBar.swift
//  百思不得姐
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

class YHNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        // 隐藏分割线
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.shadowImage = UIImage()
        
        super.layoutSubviews()
    }

}
