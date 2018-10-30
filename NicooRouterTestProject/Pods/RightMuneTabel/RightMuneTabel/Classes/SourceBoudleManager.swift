//
//  SourceBoudleManager.swift
//  CLVideo
//
//  Created by 小星星 on 2018/6/26.
//

import UIKit

class SourceBoudleManager: NSObject {
    
    class func foundImage(imageName: String) -> UIImage? {
        let bundleB  = Bundle(for: self.classForCoder()) //先找到最外层Bundle
        guard let resrouseURL = bundleB.url(forResource: "RightMuneTabel", withExtension: "bundle") else { return nil }
        let bundle = Bundle(url: resrouseURL) // 根据URL找到自己的Bundle
        return UIImage(named: imageName, in: bundle , compatibleWith: nil) //在自己的Bundle中找图片
    }
    
    class func retureNumber(_ params: [String: Any]) -> Int{
        print("只要\(998)")
        return 998
    }
    class func retureString() -> String{
        return "我爱中国男足"
    }
    class func retureStringArray() -> [String]{
        return ["NicooYang","saytoWorld","我爱中国男足"]
    }
    class func retureIntArray(_ params:[String: Any]) -> [Int]{
        print("带中文未解码：params = \(params["home"]), \(params["girlFriend"])")
        return [1,2,3,4,5,6,7]
    }
}
