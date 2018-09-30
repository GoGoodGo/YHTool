//
//  MultipleSelectionImage.swift
//  TianMaUser
//
//  Created by Healson on 2018/8/9.
//  Copyright © 2018 YH. All rights reserved.
//

import AVFoundation
import Photos
import QBImagePickerController

public class MultipleImage: NSObject {
    
    var qbImgPickerCtrl: QBImagePickerController? = nil
    var imgs = [PHAsset]()
    var totalImgs = [UIImage]()
    var currentSelectedPicCount = 0
    public var numOfPicCanSelected = 9
    public var addPicCompletionBlock: ((_ getImgs: [UIImage]) -> Void)?
    var controller: UIViewController?
    
    public init(ctrl: UIViewController) {
        controller = ctrl
        super.init()
    }
    
    /** 拍照 */
    public func getImgFromCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if status == .restricted || status == .denied {
                controller?.alertViewCtrl(title: "提示", message: "您尚未开启相机权限", sureTitle: "去开启", sureHandler: { (action) in
                    let url = URL.init(string: UIApplication.openSettingsURLString)
                    if UIApplication.shared.canOpenURL(url!) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL.init(string: "prefs:root=Privacy&path=CAMERA")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL.init(string: "prefs:root=Privacy&path=CAMERA")!)
                        }
                    }
                }, cancelHandler: nil)
            } else {
                controller?.present(imgPickerCtrl, animated: true, completion: nil)
            }
        } else {
            controller?.showAutoHideHUD(message: "该设备相机不可用！", toView: controller?.view)
        }
    }
    
    /** 相册选择图片 */
    public func getImgFromPhotoLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            qbImgPickerCtrl = QBImagePickerController.init()
            qbImgPickerCtrl?.mediaType = .image
            qbImgPickerCtrl?.showsNumberOfSelectedAssets = true
            qbImgPickerCtrl?.delegate = self
            qbImgPickerCtrl?.allowsMultipleSelection = true
            controller?.present(qbImgPickerCtrl!, animated: true, completion: nil)
            
        } else {
            controller?.showAutoHideHUD(message: "该设备不允许从相册获取文件!", toView: controller?.view)
        }
    }
    
    /** 获取选中图片 */
    func getPic(assets: [PHAsset]) {
        
        let scale = UIScreen.main.scale
        let options = PHImageRequestOptions()
        options.resizeMode = .none
        options.deliveryMode = .highQualityFormat
        
        var flag = 0
        for (_, asset) in assets.enumerated() {
            
            let size = CGSize.init(width: CGFloat(asset.pixelWidth) / scale, height: CGFloat(asset.pixelHeight) / scale)
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .default, options: options, resultHandler: { (image, info) in
                flag += 1
                let newImg = image?.zoomedImage(width: WIDTH)
                self.totalImgs.append(newImg!)
                
                if let getPicBlock = self.addPicCompletionBlock {
                    if flag == assets.count {
                        getPicBlock(self.totalImgs)
                    }
                }
            })
        }
    }
    
    // MARK: - Getter
    private lazy var imgPickerCtrl: UIImagePickerController = {
        
        let pickerCtrl = UIImagePickerController.init()
        pickerCtrl.delegate = self
        pickerCtrl.modalTransitionStyle = .flipHorizontal
        pickerCtrl.sourceType = .camera
        return pickerCtrl
    }()
}

extension MultipleImage: QBImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - QBImagePickerControllerDelegate
    public func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, shouldSelect asset: PHAsset!) -> Bool {
        if totalImgs.count + currentSelectedPicCount < numOfPicCanSelected {
            currentSelectedPicCount += 1
            imgs.append(asset)
            return true
        } else {
            let hintMessage = String.init(format: "只能选择%ld张图片", numOfPicCanSelected)
            controller?.showAutoHideHUD(message: hintMessage, toView: imagePickerController.view)
            return false
        }
    }
    
    public func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didDeselect asset: PHAsset!) {
        
        currentSelectedPicCount -= 1
        for (index, value) in imgs.enumerated() {
            if value == asset {
                imgs.remove(at: index)
                return
            }
        }
    }
    
    public func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        controller?.dismiss(animated: true, completion: nil)
        currentSelectedPicCount = 0
        getPic(assets: imgs)
    }
    
    public func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        var hintMessage = "照片选择"
        if assets.count > 0 {
            imgs = Array.init()
            imgs = assets as! [PHAsset]
            hintMessage = String.init(format: "您已成功选择%ld张照片", assets.count)
        } else {
            hintMessage = "您还未选择照片!"
        }
        controller?.showAutoHideHUD(message: hintMessage, toView: imagePickerController.view) {
            imagePickerController.dismiss(animated: true, completion: nil)
            self.currentSelectedPicCount = 0
            self.getPic(assets: self.imgs)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let zoomImg = image.zoomedImage(width: 400)
        if let getPicBlock = self.addPicCompletionBlock {
            totalImgs.append(zoomImg)
            getPicBlock(totalImgs)
        }
        controller?.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controller?.dismiss(animated: true, completion: nil)
    }
    
}

















// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
