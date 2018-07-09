//
//  RouterTestClass.swift
//  Pods-RouterTestModule_Example
//
//  Created by 小星星 on 2018/7/9.
//
import UIKit

import NicooSwiftRouter
// 这里是要通过路由从其他组件拿数据的调用
open class RouterTestClass: NSObject {
    
    class func shareToplatform(_ url: URL?) -> Any? {
        guard let shareUrl = url else {
            return ""
        }
        return NicooRouter.shareInstance.performAction(url: shareUrl , completion: nil)
    }
    open class func getMessageFormOtherModule(_ index: Int) -> Any? {
        if index == 1 {
            
            /// 通过URL来调用 Target_RouterManager 的 getString 方法 。命名空间为： 主工程 NicooRouterTestProject  因为是从 Target_RouterManager取数据。所以空间命名是  Target_RouterManager类的所属空间。 // 加上 “Target_" 和 “Server_” 是为了让大家养成好的习惯，也让结构更新清晰，一眼就能看出，前缀为target的类，是暴露给路由的API
            
            let str = "NicooRouterTestProject://RouterManager/getString"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? String  else {
                return "没成功"
            }
            print("这里已经从主工程拿到了组件 RightMuneTabel 内返回的：string： - \(value)")
            
            // 我这里直接 return到主工程，也可以不 return, 也可以加工后RETURE，根据项目需求来搞
            return value
        }
        if  index == 2 {
            let str = "NicooRouterTestProject://RouterManager/getStingArray"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? [String]  else {
                return ["没成功", "没成功"]
            }
            return value
        }
        
        //  后面两个是带参数的
        
        if  index == 3 {
            let str = "NicooRouterTestProject://RouterManager/getInt?name=NicooYang&age=27&money=0"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? Int  else {
                return 0
            }
            return value
        }
        if  index == 4 {
            let str = "NicooRouterTestProject://RouterManager/getIntArray?home=猫屎咔咔&girlFriend=100个"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? [Int]  else {
                return [0, 0]
            }
            return value
        }
        if  index == 5 {
            let str = "NicooRouterTestProject://RouterManager/getImage"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? UIImage  else {
                return nil
            }
            return value
        }
        return "瓜嘻嘻的，参数越界了"
    }
    
    
}


