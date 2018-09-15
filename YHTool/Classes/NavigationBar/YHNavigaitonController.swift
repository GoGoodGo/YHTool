//
//  YHNavigaitonController.swift
//  百思不得姐
//
//  Created by YH_O on 2017/3/10.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

public class YHNavigaitonController: UINavigationController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = .white
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        
        setValue(YHNavigationBar(), forKeyPath: "navigationBar")
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.item(image: "ico_img_jt.png", highligtImage: nil, title: nil, target: self, action: #selector(action_PopBack))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func action_PopBack() {
        self.popViewController(animated: true)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
