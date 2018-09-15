//
//  ItemCell.swift
//  E_Business
//
//  Created by YH_O on 2017/4/26.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSubviews()
    }
    
    // MARK: - PrivateMethod
    private func setupSubviews() {
        
        
    }
    // MARK: - Setter
    public var background: UIColor = .white {
        didSet {
            backgroundColor = background
            itemLabel.backgroundColor = background
        }
    }
    
    public var normalColor: UIColor = .white {
        didSet {
            itemLabel.textColor = isSelected ? selectedColor : normalColor
        }
    }
    
    public var selectedColor: UIColor = .black {
        didSet {
            itemLabel.textColor = isSelected ? selectedColor : normalColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            itemLabel.textColor = isSelected ? selectedColor : normalColor
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
