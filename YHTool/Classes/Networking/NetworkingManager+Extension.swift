//
//  NetworkingManager+Extension.swift
//  E_User
//
//  Created by YH_O on 2017/5/24.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

public typealias Failure = (_ error: Error?) -> Void
let timeoutInterval: TimeInterval = 10

extension UIViewController {
    
    // MARK: - GET 请求 转换为模型
    public func getRequest<T: Mappable>(baseUrl: String, params: Dictionary<String, String>?, success: @escaping (_ response: T) -> Void, failure: @escaping Failure) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = timeoutInterval
        manager.request(baseUrl, method: .get, parameters: params).validate().responseObject { (response: DataResponse<T>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - GET 请求 转换为模型数组
    public func getRequestList<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: [T]) -> Void, failure: @escaping Failure) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = timeoutInterval
        manager.request(baseUrl, method: .get, parameters: params).validate().responseArray { (response: DataResponse<[T]>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - POST 请求 转换为模型
    public func postRequest<T: Mappable>(baseUrl: String, params: Dictionary<String, String>?, success: @escaping (_ response: T) -> Void, failure: @escaping Failure) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = timeoutInterval
        manager.request(baseUrl, method: .post, parameters: params).validate().responseObject { (response: DataResponse<T>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - POST 请求 转换为模型数组
    public func postRequestList<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: [T]) -> Void, failure: @escaping Failure) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = timeoutInterval
        manager.request(baseUrl, method: .post, parameters: params).validate().responseArray { (response: DataResponse<[T]>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - 检查请求返回状态
    public func inspect(code: Int?, msg: String? = "提示") {
        
        showAutoHideHUD(message: msg!, toView: UIApplication.shared.windows.last)
    }
    
    public func inspect(model: BaseModel) {
        if model.msg == "登录失败,请重新登录" {
            
        }
        showAutoHideHUD(message: model.msg!)
    }
    
    // MARK: - 检查请求失败原因
    public func inspectError() {
        self.hideHUD()
        NetworkingManager.networkReachability { [weak self] (status) in
            if (status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi) || (status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(NetworkReachabilityManager.ConnectionType.wwan))) {
                self?.showAutoHideHUD(message: "服务器出问题了!", toView: UIApplication.shared.windows.last)
            } else {
                self?.showAutoHideHUD(message: "无网络服务!", toView: UIApplication.shared.windows.last)
            }
        }
    }
    // MARK: - 退出
    public func logout() {
        
        Singleton.shared.uid = ""
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: isLogin)
        
        userDefaults.synchronize()
        
//        UIApplication.shared.keyWindow?.rootViewController = YHNavigaitonController.init(rootViewController: LoginController())
    }
    
    
    
    
    
    
    
    
    
}
