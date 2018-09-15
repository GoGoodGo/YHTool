//
//  YHSegmentView.swift
//
//  Created by YH_O on 2017/4/26.
//  Copyright © 2017年 OYH. All rights reserved.
//

import UIKit

let indicatorH: CGFloat = 2

public class YHSegmentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    public var clickItemBlock: ((_ index: Int) -> Void)?
    
    public init(frame: CGRect, titles: Array<String>) {
        
        super.init(frame: frame)
        self.titles = titles
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethod
    public func setupSelectedItem(index: Int) {
        
        selectedItem(index: index)
    }
    
    // MARK: - PrivateMethod
    private func setupSubviews() {
        
        addSubview(collectionView)
        layer.addSublayer(separatorLayer)
        collectionView.addSubview(indicatorView)
        
        // Default Selected
        selectedItem(index: 0)
    }
    /** 选中的 item */
    private func selectedItem(index: Int) {
        
        let indexPath = IndexPath.init(row: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        let selectedItem = collectionView(collectionView, cellForItemAt: indexPath) as! ItemCell
        layoutLayerFrame(item: selectedItem)
    }
    
    /** 根据选中的 item 布局 layer 指示器 */
    private func layoutLayerFrame(item: ItemCell) {
        
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.centerX = item.centerX
        }
    }
    
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCell.self), for: indexPath) as! ItemCell
        cell.normalColor = normalColor
        cell.background = background
        cell.selectedColor = selectedColor
        cell.itemLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = collectionView.cellForItem(at: indexPath) as! ItemCell
        layoutLayerFrame(item: selectedItem)
        
        if let clickItem = clickItemBlock {
            clickItem(indexPath.row)
        }
    }
    
    // MARK: - Setter
    public var titles = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var normalColor: UIColor = .lightGray {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var selectedColor: UIColor = .white {
        didSet {
            selectedItem(index: 0)
        }
    }
    
    public var background: UIColor = .white {
        didSet {
            collectionView.backgroundColor = background
            collectionView.reloadData()
        }
    }
    
    public var indicatorColor: UIColor = .white {
        didSet {
            indicatorView.backgroundColor = indicatorColor
        }
    }
    
    public var separatorColor: UIColor = .white {
        didSet {
            separatorLayer.backgroundColor = separatorColor.cgColor
        }
    }
    
    public var itemW: CGFloat = 60.0 {
        didSet {
            layout.itemSize = CGSize.init(width: itemW, height: self.height)
            selectedItem(index: 0)
        }
    }
    
    public var indicatorW: CGFloat = 50.0 {
        didSet {
            var temp = indicatorView.frame
            temp.size.width = indicatorW
            indicatorView.frame = temp
            selectedItem(index: 0)
        }
    }
    
    // MARK: - Getter
    private lazy var layout: UICollectionViewFlowLayout = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: WIDTH / CGFloat(self.titles.count), height: self.height)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
       
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        let bundle = Bundle.init(for: type(of: self))
        let url = bundle.url(forResource: "YHTool", withExtension: "bundle")
        view.register(UINib.init(nibName: String(describing: ItemCell.self), bundle: Bundle.init(url: url!)), forCellWithReuseIdentifier: String(describing: ItemCell.self))
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var indicatorView: UIImageView = {
        
        let view = UIImageView.init(frame: CGRect(x: 0, y: self.height - indicatorH, width: WIDTH / CGFloat(self.titles.count) - 40, height: indicatorH))
        view.backgroundColor = indicatorColor
        
        return view
    }()
    
    private lazy var separatorLayer: CALayer = {
        
        let layer = CALayer.init()
        layer.frame = CGRect.init(x: 0, y: self.height - 1, width: WIDTH, height: 1)
        layer.backgroundColor = separatorColor.cgColor
        return layer
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
