//
//  PublicFile.swift
//
//  Created by 欧阳辉 on 2017/3/9.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit

// key
public let isLogin = "isLoggedIn"
public let UID = "uid"

public let MainColor = YHRGBColor(119, 54, 20)
public let OrangeColor = YHRGBColor(235, 128, 50)
public let SeparatorColor = YHRGBColor(245, 245, 245)

public let VerifyCodeLength = 6
public let BannerH = HeightPercent(120.0)

public let Banners: () -> Array<String>? = { ["banner_one", "banner_two"] }

public let CellName: (AnyClass) -> String = { cellClass in
    
    return String(describing: cellClass)
}

// 打印
public func YHPrint<T> (message: T) {
    
    #if DEBUG
    print("\(message)->line:\(#line)<\(NSString.init(string: "\(#file)").lastPathComponent)>")
    #endif
}

// iPhone Devices
public let iPhone5: () -> Bool = { HEIGHT ==  568.0 }

public let iPhone6: () -> Bool = { HEIGHT ==  667 }

public let iPhone6P: () -> Bool = { HEIGHT ==  736.0 }

// iOS 系统版本
public let iOS7_ABOVE = UIDevice.current.systemVersion.compare("7.0").hashValue

// 宽高比例计算
public let WidthPercent: (CGFloat) -> CGFloat = { figure in
    
    return figure / 320.0 * WIDTH
}

public let HeightPercent: (CGFloat) -> CGFloat = { figure in
    
    return figure / 568.0 * HEIGHT
}

// RGB 颜色设置
public let YHRGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = { R, G, B in
    
    return UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
}
public let YHRGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = { R, G, B, A in
    
    return UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
}

/** HexString */
public let HexString: (String) -> UIColor = { hexStr in
    
    var hex = hexStr
    if hexStr.hasPrefix("#") {
         hex = hex.substring(s: 1)
    }
    let scanner = Scanner.init(string: hex)
    scanner.scanLocation = 0
    var rgbValue: UInt64 = 0
    scanner.scanHexInt64(&rgbValue)
    
    return HexRGB(rgbValue)
}

// HexColor
public let HexRGB: (UInt64) -> UIColor = { RGBValue in
    
    let red = ((CGFloat)((RGBValue & 0xFF0000) >> 16)) / 255.0
    let green = ((CGFloat)((RGBValue & 0xFF00) >> 8)) / 255.0
    let blue = ((CGFloat)(RGBValue & 0xFF)) / 255.0
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
}
public let HexRGBA: (UInt64, CGFloat) -> UIColor = { RGBValue, Alpha in
    
    let red = ((CGFloat)((RGBValue & 0xFF0000) >> 16)) / 255.0
    let green = ((CGFloat)((RGBValue & 0xFF00) >> 8)) / 255.0
    let blue = ((CGFloat)(RGBValue & 0xFF)) / 255.0
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: Alpha)
}
// 图片
public let IMG: (String) -> UIImage? = { imgName in

    return UIImage.init(named: imgName)
}

// 命名空间
public let NameSpace = Bundle.main.infoDictionary!["CFBundleName"] as! String + "."

/** 获取 bundle */
public let getBundle: (AnyClass) -> Bundle = { any in
    
    let bundle = Bundle.init(for: any)
    let url = bundle.url(forResource: (bundle.infoDictionary?["CFBundleName"] as! String), withExtension: "bundle")
    return Bundle.init(url: url!)!
}
/** 获取 bundle by bundle name */
public let getBundleWithName: (AnyClass, String) -> Bundle = { any, name in
    
    let bundle = Bundle.init(for: any)
    let url = bundle.url(forResource: name, withExtension: "bundle")
    return Bundle.init(url: url!)!
}


// 提示框显示时间
public let hudHiddenTime = 0.8

// 屏幕宽高
public let WIDTH = UIScreen.main.bounds.width
public let HEIGHT = UIScreen.main.bounds.height

public let TabBarH: CGFloat = 49
public let NavigationBarH: CGFloat = 64




















