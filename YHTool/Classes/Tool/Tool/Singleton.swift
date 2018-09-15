//
//  Singleton.swift
//  E_User
//
//  Created by YH_O on 2017/5/25.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation

public final class Singleton {
    
    public var uid = ""
    public var token = "2E214A98E2FEAF00DF358020F0A60021"
    
    public static let shared = Singleton()
    
    // MARK: - PrivateMethod
    private init() {}
    
    
}
