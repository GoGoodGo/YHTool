//
//  ViewController.swift
//  YHTool
//
//  Created by OYHHYO on 09/15/2018.
//  Copyright (c) 2018 OYHHYO. All rights reserved.
//

import UIKit
import YHTool

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
    
        let segmentView = YHSegmentView.init(frame: CGRect.init(x: 0, y: 50, width: WIDTH, height: 50), titles: ["哈哈", "哈哈哈哈哈", "测试"])
        view.addSubview(segmentView)
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem.itemBundle(bundle: getBundle(Singleton.self), image: "back", target: self, action: #selector(search))
    }
    
    @objc func search() {
        print("click back")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    

}

