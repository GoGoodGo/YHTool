//
//  String+Extension.swift
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    /************************ 其他 **************************/
    // MARK: - 图片地址拼接
    public func imgUrlAppend(url: String) -> String {
        
        let totalUrl = url + self
        return totalUrl
    }
    
    /** 用","拼接ids */
    public static func jointIds(idArr: Array<String>) -> String {
        var ids = ""
        for (index, id) in idArr.enumerated() {
            ids.append(id)
            if index != idArr.count - 1 {
                ids.append(",")
            }
        }
        return ids
    }
    
    // MARK: - 字符串截取
    public func substring(s: UInt, _ e: UInt? = nil) -> String {
        
        let start = self.index(self.startIndex, offsetBy: s)
        guard let value = e else { return String(self[start ..< self.endIndex]) }
        
        let end = self.index(self.startIndex, offsetBy: value)
        return String(self[start ..< end])
    }
    
    /********************** 文本工具 ************************/
    // MARK: - 计算文本的 Size
    public func textSize(font: UIFont, maxSize: CGSize) -> CGSize {
        
        var newSize = NSString.init(string: self).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        
        newSize.width += 4
        
        return newSize
    }
    
    // MARK: - 文本增加删除线
    public func addStrikethrough() -> NSMutableAttributedString {
        
        let length = NSString.init(string: self).length
        let range = NSRange.init(location: 0, length: length)
        
        let attributeStr = NSMutableAttributedString.init(string: self)
        
        attributeStr.addAttributes([NSAttributedString.Key.baselineOffset : 0, NSAttributedString.Key.strikethroughStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray], range: range)
        
        return attributeStr
    }
    
    /********************** 正则表达式 ************************/
    
    // MARK: - 是否有效邮箱
    public func isValidateEmail() -> Bool {
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return isValidate(regex: emailRegex)
    }
    
    // MARK: - 是否有效电话
    public func isValidateMobile() -> Bool {
        
        let Mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$"
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$"
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$"
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        
        if isValidate(regex: Mobile) || isValidate(regex: CM) || isValidate(regex: CU) || isValidate(regex: CT) {
            return true
        }
        return false
    }
    
    // MARK: - 是否包含特殊字符
    public func isContainsSpecialChar() -> Bool {
        
        let specialCharRegex = "[^a-zA-Z0-9\u{4e00}-\u{9fa5}]"
        return isValidate(regex: specialCharRegex)
    }
    
    // MARK: - 正则判断
    private func isValidate(regex: String) -> Bool {
        
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    // MARK: - 是否包含表情
    public func isContainsEmoji() -> Bool {
        
        var isEomji = false
        NSString.init(string: self).enumerateSubstrings(in: NSRange.init(location: 0, length: NSString.init(string: self).length), options: .byComposedCharacterSequences) { (subString, subStrRange, enclosingRange, stop) in
            let str: NSString = NSString.init(string: subString!)
            let hs: unichar = str.character(at: 0)
            if hs >= 0xd800 && hs <= 0xdbff {
                if str.length > 1 {
                    let ls: unichar = (str.character(at: 1) - 0xdc00)
                    let uc: UInt64 = UInt64(((hs - 0xd800) * 0x400)) + UInt64(0x10000) + UInt64(ls)
                    if 0x1d000 <= uc && uc <= 0x1f77f {
                        isEomji = true
                    }
                }
            } else if str.length > 1 {
                let ls = str.character(at: 1)
                if ls == 0x20e3 || ls == 0xfe0f {
                    isEomji = true
                }
            } else {
                if 0x2100 <= hs && hs <= 0x27ff && hs != 0x263b {
                    isEomji = true
                } else if 0x2B05 <= hs && hs <= 0x2b07 {
                    isEomji = true
                } else if 0x2934 <= hs && hs <= 0x2935 {
                    isEomji = true
                } else if 0x3297 <= hs && hs <= 0x3299 {
                    isEomji = true
                } else if hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0x231a {
                    isEomji = true
                }
            }
        }
        return isEomji
    }

    // MARK: - 是否有效身份证号
    public func isValidateIDCard() -> Bool {
        
        let IDCardNum = NSString.init(string: trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))
        if IDCardNum.length != 18 {
            return false
        }
        
        let mmdd = "(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))"
        let leapMMdd = "0229"
        let year = "(17|18|19|20)[0-9]{2}"
        let leapYear = "(19|20)(0[48]|[2468][048]|[13579][26])"
        let yearMMdd = year + mmdd
        let leapYearMMdd = leapYear + leapMMdd
        let yyyyMMdd = yearMMdd + leapYearMMdd + "20000229"
        let area = "(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}"
        let regex = area + yyyyMMdd + "[0-9]{3}[0-9Xx]"
        
        if isValidate(regex: regex) {
            return false
        }
        
        let a = (Int(IDCardNum.substring(with: NSRange.init(location: 0, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 10, length: 1)))!) * 7
        let b = (Int(IDCardNum.substring(with: NSRange.init(location: 1, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 11, length: 1)))!) * 9
        let c = (Int(IDCardNum.substring(with: NSRange.init(location: 2, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 12, length: 1)))!) * 10
        let d = (Int(IDCardNum.substring(with: NSRange.init(location: 3, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 13, length: 1)))!) * 5
        let e = (Int(IDCardNum.substring(with: NSRange.init(location: 4, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 14, length: 1)))!) * 8
        let f = (Int(IDCardNum.substring(with: NSRange.init(location: 5, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 15, length: 1)))!) * 4
        let g = (Int(IDCardNum.substring(with: NSRange.init(location: 6, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 16, length: 1)))!) * 2
        let h = (Int(IDCardNum.substring(with: NSRange.init(location: 7, length: 1)))! + Int(IDCardNum.substring(with: NSRange.init(location: 8, length: 1)))!) * 6
        let i = Int(IDCardNum.substring(with: NSRange.init(location: 9, length: 1)))! * 3
        
        let summary = a + b + c + d + e + f + g + h + i
        
        let remainder = summary % 11
        var checkBit = ""
        let checkStr: NSString = NSString.init(string: "10x98765432")
        checkBit = checkStr.substring(with: NSRange.init(location: remainder, length: 1))
        
        return checkBit == (IDCardNum.substring(with: NSRange.init(location: 17, length: 1)).uppercased())
    }
    
    /************************* MD5 ***************************/
    
    // MARK: - 获取时间戳
    public func getTimestamp() -> String {
        
        let timestamp = Date().timeIntervalSince1970
        let timestampStr = String.init(format: "%0.f", timestamp)
        return timestampStr
    }
    
    // MARK: - url可编码
    public func strEncoding(url: String) -> String {
        
        let characterSet = NSCharacterSet.urlQueryAllowed
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: characterSet)
        
        return urlStr!
    }
    
//    // MARK: - MD5 加密
//    public func toMD5(str: String) -> String {
//
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLength = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//
//        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
//        let resultList = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
//
//        CC_MD5(str!, strLength, resultList)
//        let hash = NSMutableString()
//        for i in 0 ..< digestLength {
//
//            hash.appendFormat("%02x", resultList[i])
//        }
//        resultList.deinitialize(count: digestLength)
//
//        return String(hash)
//    }
    
    
    
    
    
    
    
}


















