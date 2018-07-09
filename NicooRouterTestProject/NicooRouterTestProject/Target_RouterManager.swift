//
//  Target_RouterManager.swift
//  NicooRouterTestProject
//
//  Created by 小星星 on 2018/7/9.
//  Copyright © 2018年 yangxin. All rights reserved.
//

import UIKit
import RightMuneTabel
import NicooSwiftRouter


class Target_RouterManager: NSObject {

    // 路由通过调用 RightMuneTabel 中 Target_RouterApi 的方法获取想要的值。这里命名空间就为 RightMuneTabel 组件，
    
    @objc func Action_getString() ->String {
        
        return NicooRouter.shareInstance.getRouterApiData() as String
    }
    @objc func Action_getInt(_ params: [String: Any]) ->NSNumber {
        // 基本数据类型都必须转成：  NSNumber 传递出去，外面在处理
        // 这里拿到参数params 传递到 RightMuneTabe l组件中去
        return NicooRouter.shareInstance.getRouterApiInt(params) as NSNumber
    }
    @objc func Action_getStingArray() -> [String] {
        return NicooRouter.shareInstance.retureStingArray()  as [String]
    }
    @objc func Action_getIntArray(_ param: [String: Any]) -> [Int] {  // 带参数
        return NicooRouter.shareInstance.retureIntArray(param)  as [Int]
    }
    @objc func Action_getImage() -> UIImage? {
        return NicooRouter.shareInstance.getImage()
    }
   
}
