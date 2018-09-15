//
//  BaseModel.swift
//  E_User
//
//  Created by YH_O on 2017/5/25.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseModel: Mappable {
    
    public var status: String?
    public var msg: String?
    
    required public init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        
        status <- map["status"]
        msg <- map["msg"]
    }
}
