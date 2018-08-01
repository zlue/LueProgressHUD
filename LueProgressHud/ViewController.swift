//
//  ViewController.swift
//  LueProgressHud
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 lue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = LueScanAnimationView(frame: CGRect(x: 80, y: 110, width: 200, height: 200), c: UIColor.blue)
        v.backgroundColor = UIColor.clear
        view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

