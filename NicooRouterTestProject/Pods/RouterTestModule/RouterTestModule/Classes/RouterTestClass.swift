//
//  RouterTestClass.swift
//  Pods-RouterTestModule_Example
//
//  Created by 小星星 on 2018/7/9.
//
import UIKit
import NicooSwiftRouter


/*
 通过URL来调用 RightMuneTabel 组件内 Target_RouterApi 的 getRouterApiData 方法 。
 命名空间为： RightMuneTabel  因为是从 Target_RouterApi取数据。所以空间命名是  Target_RouterApi类的所属空间。
 加上 “Target_" 和 “Server_” 是为了让大家更好的区分 路由方法 和 其他方法，也让结构更新清晰，一眼就能看出，前缀为 "Target_" 的类，是组件暴露给路由的API
 */

open class RouterTestClass: NSObject {
    
    class func shareToplatform(_ url: URL?) -> Any? {
        guard let shareUrl = url else {
            return ""
        }
        return NicooRouter.shareInstance.performAction(url: shareUrl , completion: nil)
    }
    
    /// 路由通过URl调用 RightMuneTabel 组件内的 Target_RouterApi 暴露给外部有的各个API方法
    open class func getMessageFormOtherModule(_ index: Int) -> Any? {
        if index == 1 {
            let str = "RightMuneTabel://RouterApi/getRouterApiData"
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
            let str = "RightMuneTabel://RouterApi/retureStingArray"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? [String]  else {
                return ["没成功", "没成功"]
            }
            return value
        }
        //  后面两个是带参数的
        if  index == 3 {
            let str = "RightMuneTabel://RouterApi/getRouterApiInt?name=NicooYang&age=27&money=0"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? Int  else {
                return 0
            }
            return value
        }
        if  index == 4 {
            let str = "RightMuneTabel://RouterApi/retureIntArray?home=猫屎咔咔&girlFriend=100个"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? [Int]  else {
                return [0, 0]
            }
            return value
        }
        if  index == 5 {
            let str = "RightMuneTabel://RouterApi/getImage"
            let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: utf8String)!
            guard let value =  shareToplatform(url) as? UIImage  else {
                return nil
            }
            return value
        }
        return "参数越界了"
    }
    
}

// MARK: - 登录， 获取用户信息
extension RouterTestClass {
    
    /// 获取用户信息
    ///
    /// - Returns: userInfo
    
    func getUserInfoMessage() ->[String :Any]? {
        var userInfo = [String: Any]()
        userInfo["name"] = "NicooYang"
        userInfo["gender"] = "X"        // X or O
        userInfo["school"] = "CDU"
        userInfo["age"] = "27"
        userInfo["motto"] = "Learn wisdom by the follies of others."
        return userInfo
    }
}

