//
//  YHTextView.swift
//  YHPlaceholderTextView
//
//  Created by Healson on 01/12/2017.
//  Copyright © 2017 YH. All rights reserved.
//

import UIKit

public class YHTextView: UITextView {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        placeholderColor = YHRGBColor(200, 200, 205)
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override public func draw(_ rect: CGRect) {
        
        if hasText { return }
        
        var tempRect = rect
        tempRect.origin.x = 2
        tempRect.origin.y = 7
        tempRect.size.width -= 2 * tempRect.origin.x
        
        let attrs = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : placeholderColor] as [NSAttributedString.Key : Any]
        placeholder?.draw(in: tempRect, withAttributes: attrs)
    }
    
    // MARK: - Callbacks
    @objc func textDidChange() {
        setNeedsDisplay()
    }
    
    // MARK: - Setter
    public var placeholder: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var placeholderColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    
    
    

}
