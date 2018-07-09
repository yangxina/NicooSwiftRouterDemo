//
//  ViewController.swift
//  NicooRouterTestProject
//
//  Created by 小星星 on 2018/7/9.
//  Copyright © 2018年 yangxin. All rights reserved.
//

import UIKit
import RouterTestModule
class ViewController: UIViewController {

    @IBOutlet weak var imageViewss: UIImageView!
    @IBAction func gan(_ sender: UIButton) {
        if sender.tag == 1 {
            if let str = RouterTestClass.getMessageFormOtherModule(1) as? String {
                print("路由获取字符串 = \(str)")
            }
        }
        if sender.tag == 2 {
            if let strArray = RouterTestClass.getMessageFormOtherModule(2) as? [String] {
                print("路由获取字符串数组 = \(strArray)")
            }
        }
        if sender.tag == 3 {
            if let number = RouterTestClass.getMessageFormOtherModule(3) as? Int {
                print("路由获取基本数据类型 = \(number)")
            }
        }
        if sender.tag == 4 {
            if let numberArray = RouterTestClass.getMessageFormOtherModule(4) as? [Int] {
                print("路由获取组件信息 = \(numberArray)")
            }
        }
        if sender.tag == 5 {
            if let backimage = RouterTestClass.getMessageFormOtherModule(5) as? UIImage {
                self.imageViewss.image = backimage
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

