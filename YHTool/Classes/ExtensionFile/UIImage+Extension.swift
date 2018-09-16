//
//  UIImage+Extension.swift
//
//  Created by YH_O on 2017/3/11.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - 图片压缩
    public func zoomedImage(width: CGFloat) -> UIImage {
        
        var imgWidth = size.width
        var imgHeight = size.height
        
        if imgWidth > width {
            imgHeight = width / imgWidth * imgHeight
            imgWidth = width
        }
        UIGraphicsBeginImageContext(CGSize.init(width: imgWidth, height: imgHeight))
        draw(in: CGRect.init(x: 0, y: 0, width: imgWidth, height: imgHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // MARK: - 裁剪图片
    public func clipImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        // 圆的区域
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        // 在上下文中添加圆的 rect
        ctx!.addEllipse(in: rect)
        // 裁剪
        ctx!.clip()
        // 绘制
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    /** 获取二维码 */
    static public func getQRCode(info: String) -> UIImage {
        
        let filter = CIFilter.init(name: info)
        filter?.setDefaults()
        
        let data = info.data(using: .utf8)
        filter?.setValue(data, forKey: "inputMessage")
        let outputImg = filter?.outputImage
        
        let image = conversionImage(image: outputImg!, size: 200)
        return image
    }
    
    static private func conversionImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        
        let width = extent.size.width * scale
        let height = extent.size.height * scale
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext.init(options: nil)
        let bitmapImage = context.createCGImage(image, from: extent)!
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        
        let img = bitmapRef.makeImage()!
        
        return UIImage.init(cgImage: img)
    }
    
}

























