//
//  YHTabBarController.swift
//
//  Created by YH_O on 2017/3/9.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

public class YHTabBarController: UITabBarController {

    let vcNameList = ["HomeController", "GoodsController", "CartController", "IncomeController", "MineController"]
    let titleList = ["首页", "商品", "购物车", "收益", "我的"]
    let normalImgList = ["ico_img_indexw.png", "ico_img_spw.png", "ico_img_gwcw.png", "ico_img_wdsyw.png", "ico_img_wdw.png"]
    let selectedImgList = ["ico_img_index.png", "ico_img_sp.png", "ico_img_gwc.png", "ico_img_wdsy.png", "ico_img_wd.png"]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupSubviews()
    }
    
    // MARK: - 配置子视图
    private func setupSubviews() {
        
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : HexString("#cccccc")], for: .normal)
        itemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : HexString("#ff5863")], for: .selected)
        
        for index in 0 ..< self.vcNameList.count {
            
            let vcName = self.vcNameList[index]
            let VC = (NSClassFromString(NameSpace + vcName) as! UIViewController.Type).init()
            VC.tabBarItem.title = self.titleList[index]
            VC.tabBarItem.image = UIImage.init(named: self.normalImgList[index])
            VC.tabBarItem.selectedImage = UIImage.init(named: self.selectedImgList[index])?.withRenderingMode(.alwaysOriginal)
            let navigationCtrl = YHNavigaitonController.init(rootViewController: VC)
            navigationCtrl.title = self.titleList[index]
            
            addChildViewController(navigationCtrl)
        }
        self.setValue(YHTabBar(), forKeyPath: "tabBar")
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
