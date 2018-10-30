//
//  Target_RouterApi.swift
//  Pods
//
//  Created by 小星星 on 2018/7/6.
//

import UIKit


/* 这里是组件：RightMuneTable 想要给外部暴露的API，其他组件只能通过调用这里面的方法来来与 当前组件 RightMuneTable 传递数据，或者调用方法。
*/

class Target_RouterApi: NSObject {
    
    /// - Returns: 这里要注意的是，返回值的类型必须为 对象类型，路由是由 OC改写而来，这个规定了要用对象类型，OC类型安全
    @objc func Action_getRouterApiData() ->String {
        return SourceBoudleManager.retureString()
    }
    
    /// 基本数据类型都必须转成：  NSNumber 传递出去，外面在处理
    @objc func Action_getRouterApiInt(_ params: [String: Any]) ->NSNumber {
        print("先看看参数 = 姓名：\(String(describing: params["name"]))-- 年龄：\(String(describing: params["age"])) -- 钱：\(String(describing: params["money"]))")
        return SourceBoudleManager.retureNumber(params) as NSNumber
    }
    
    @objc func Action_retureStingArray() -> [String] {
        return SourceBoudleManager.retureStringArray()
    }
    
    @objc func Action_retureIntArray(_ param: [String: Any]) -> [Int] {
        // 参数中有中文时，来个中文编解码
        if let home = param["home"] as? String, let girlFriend = param["girlFriend"] as? String {
            print("home = \(String(describing: home.removingPercentEncoding)), girlFriend = \(String(describing: girlFriend.removingPercentEncoding))")
        }
        
        return SourceBoudleManager.retureIntArray(param)
    }
   
    @objc func Action_getImage() -> UIImage?{
        guard let image = SourceBoudleManager.foundImage(imageName: "muneBg") else {
            return nil
        }
        return image
    }
    
}
