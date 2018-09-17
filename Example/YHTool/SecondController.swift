//
//  SecondController.swift
//  YHTool_Example
//
//  Created by Healson on 2018/9/17.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import YHTool

class SecondController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem.itemBundle(bundle: getBundle(Singleton.self), image: "back", target: self, action: #selector(search))
    }
    
    @objc func search() {
        print("click back")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
