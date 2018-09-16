//
//  NetworkingManager.swift
//
//  Created by YH_O on 2017/3/20.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

public typealias SuccessBlock = (_ responseObj: JSON) -> Void
public typealias FailureBlock = (_ error: Error?) -> Void
public typealias MultipartFormDataBlock = (_ multipartFormData: MultipartFormData) -> Void
public typealias ReachabilityStatusBlock = (_ status: NetworkReachabilityManager.NetworkReachabilityStatus) -> Void

public class NetworkingManager: NSObject {
    
    // MARK: - GET JSON
    public class func getJson(baseUrl: String, params: Dictionary<String, String>?, success: @escaping (_ response: Any) -> Void, failure: @escaping FailureBlock) {
        Alamofire.request(baseUrl, method: .get, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - GET 请求 转换为模型
    public class func getRequest<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: T) -> Void, failure: @escaping FailureBlock) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        Alamofire.request(baseUrl, method: .get, parameters: params).validate().responseObject { (response: DataResponse<T>) in
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
    public class func getRequestList<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: [T]) -> Void, failure: @escaping FailureBlock) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        Alamofire.request(baseUrl, method: .get, parameters: params).validate().responseArray { (response: DataResponse<[T]>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - POST JSON
    public class func post(baseUrl: String, params: Dictionary<String, String>?, success: @escaping (_ response: Any) -> Void, failure: @escaping FailureBlock) {
        Alamofire.request(baseUrl, method: .post, parameters: params).responseJSON { (response) in
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
    public class func postRequest<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: T) -> Void, failure: @escaping FailureBlock) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        Alamofire.request(baseUrl, method: .post, parameters: params).validate().responseObject { (response: DataResponse<T>) in
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
    public class func postRequestList<T: Mappable>(baseUrl: String, params: Dictionary<String, Any>?, success: @escaping (_ response: [T]) -> Void, failure: @escaping FailureBlock) {
        
        Alamofire.request(baseUrl, method: .post, parameters: params).validate().responseArray { (response: DataResponse<[T]>) in
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let value = response.result.value {
                success(value)
            }
        }
    }
    
    // MARK: - multipartData (image or file)
    public class func uploadMultipartData(url: String, multipart: @escaping MultipartFormDataBlock, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipart(multipartFormData)
        }, to:url) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                upload.responseJSON(completionHandler: { (response) in
                    if let respValue = response.result.value {
                        success(JSON(respValue))
                    }
                })
            case .failure(let encodingError):
                failure(encodingError)
            }
        }
    }
    
    // MARK: - 网络状态监测
    public class func networkReachability(networkStatusBlock: @escaping ReachabilityStatusBlock) {
        
        let networkManager = NetworkReachabilityManager.init()
        networkManager?.listener = { status in
            networkStatusBlock(status)
        }
        networkManager?.startListening()
    }
    
    // MARK: - uploading imgData
    public class func uploadImg(imgData: Data, toUrl: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        Alamofire.upload(imgData, to: toUrl).validate().responseJSON { (response) in
            
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            
            if let respValue = response.result.value {
                success(JSON(respValue))
            }
        }
    }
    
    // MARK: - uploading a file
    public class func uploadFile(fileUrl: URL, toUrl: String, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        Alamofire.upload(fileUrl, to: toUrl).validate().responseJSON { (response) in
            
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            if let respValue = response.result.value {
                success(JSON(respValue))
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
