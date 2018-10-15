//
//  UIViewController+Extension.swift
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

let HUDMinShowTime: TimeInterval = 0.4

extension UIViewController {
    
    /********************** 提示 ********************/
    
    // MARK: - show -> view 
    public func showHUD(view: UIView? = UIApplication.shared.windows.last) {
        var hud = MBProgressHUD.init()
        hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .determinate
        hud.minShowTime = HUDMinShowTime
        hud.removeFromSuperViewOnHide = true
    }
    
    // MARK: - hide -> view
    public func hideHUD(view: UIView? = UIApplication.shared.windows.last) {
        MBProgressHUD.hide(for: view!, animated: true)
    }
    
    // MARK: - hide all view
    public func hideAllHUD(view: UIView? = UIApplication.shared.windows.last) {
        MBProgressHUD.hideAllHUDs(for: view!, animated: true)
    }
    
    // MARK: - showAutoHideHUD
    public func showAutoHideHUD(message: String, toView view: UIView? = UIApplication.shared.windows.last) {
        
        var hud = MBProgressHUD.init()
        hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(animated: true, afterDelay: hudHiddenTime)
    }
    
    // MARK: - 自动隐藏 + completedHandler
    public func showAutoHideHUD(message: String, toView view: UIView? = UIApplication.shared.windows.last, completed: @escaping () -> Void) {
        
        var hud = MBProgressHUD.init()
        hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(animated: true, afterDelay: hudHiddenTime)
        
        let delayTime = DispatchTime.now() + hudHiddenTime
        DispatchQueue.main.asyncAfter(deadline: delayTime) { 
            completed()
        }
    }
    
    // MARK: - alertViewController
    public func alertViewCtrl(title: String? = "提示", message: String?, sureHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        
        let alertCtrl = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            if let cancelBlock = cancelHandler {
                cancelBlock(action)
            }
        }
        let sureAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
            if let sureBlock = sureHandler {
                sureBlock(action)
            }
        }
        alertCtrl.addAction(cancelAction)
        alertCtrl.addAction(sureAction)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    // MARK: - alertViewController + textField
    public func alertTextFieldViewCtrl(title: String?, message: String?, placeholder: String?, sureHandler: ((UIAlertAction, String) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        
        let alertCtrl = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertCtrl.addTextField { (textField) in
            textField.placeholder = placeholder
            textField.clearButtonMode = .whileEditing
        }
        let sureAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
            if let sureBlock = sureHandler {
                let textF = alertCtrl.textFields?.first!
                sureBlock(action, (textF?.text)!)
            }
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            if let cancelBlock = cancelHandler {
                cancelBlock(action)
            }
        }
        alertCtrl.addAction(cancelAction)
        alertCtrl.addAction(sureAction)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    // MARK: - alertViewController + sureTitle
    public func alertViewCtrl(title: String?, message: String?, sureTitle: String?, sureHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        
        let alertCtrl = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            if let cancelBlock = cancelHandler {
                cancelBlock(action)
            }
        }
        let sureAction = UIAlertAction.init(title: sureTitle, style: .default) { (action) in
            if let sureBlock = sureHandler {
                sureBlock(action)
            }
        }
        alertCtrl.addAction(cancelAction)
        alertCtrl.addAction(sureAction)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    // MARK: - alertViewControllerTakePicture
    public func alertViewCtrlSelectePic(cancelHandler: ((UIAlertAction) -> Void)?, takePicHandler: ((UIAlertAction) -> Void)?, photoLibraryHandler: ((UIAlertAction) -> Void)?) {
        
        let alertCtrl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            if let cancelBlock = cancelHandler {
                cancelBlock(action)
            }
        }
        let takePicAction = UIAlertAction.init(title: "拍照", style: .default) { (action) in
            if let takePicBlock = takePicHandler {
                takePicBlock(action)
            }
        }
        let photoLibraryAction = UIAlertAction.init(title: "从手机相册选择", style: .default) { (action) in
            if let photoLibraryBlock = photoLibraryHandler {
                photoLibraryBlock(action)
            }
        }
        alertCtrl.addAction(cancelAction)
        alertCtrl.addAction(takePicAction)
        alertCtrl.addAction(photoLibraryAction)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}


















