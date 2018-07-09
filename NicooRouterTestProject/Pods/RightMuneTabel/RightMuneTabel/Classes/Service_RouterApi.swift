//
//  Service_RouterApi.swift
//  Pods
//
//  Created by 小星星 on 2018/7/6.
//

import Foundation
import NicooSwiftRouter

public extension NicooRouterManager {
    
    fileprivate static let  kNameSpace = "RightMuneTabel"
    fileprivate static let  kTarget = "RouterApi"
    fileprivate static let  kSelector1 = "getRouterApiData"
    fileprivate static let  kSelector2 = "retureStingArray"
    fileprivate static let  kSelector3 = "retureIntArray"
    fileprivate static let  kSelector4 = "getRouterApiInt"
    fileprivate static let  kSelector5 = "getImage"
}
public extension NicooRouter {
    
    /// 这里是暴露给外部调用的方法 ：
    
    /*  kSelector1  */
    public func getRouterApiData() -> String {
        let value = perform(action: NicooRouterManager.kSelector1, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNameSpace, withParams: nil)
        guard let strings = value as? String else {
            return "没有成功啊"
        }
        return strings
    }
    /*   kSelector2    */
    public func retureStingArray() -> [String] {
        let value = perform(action: NicooRouterManager.kSelector2, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNameSpace, withParams: nil)
        guard let stringArray = value as? [String] else {
            return []
        }
        return stringArray
        
    }
    /*   kSelector3    */
    public func retureIntArray(_ params: [String: Any]?) -> [Int] {
        let value = perform(action: NicooRouterManager.kSelector3, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNameSpace, withParams: params)
        guard let IntArray = value as? [Int] else {
            return []
        }
        return IntArray
    }
    
    /*   kSelector4    */
    public func getRouterApiInt(_ params: [String: Any]?) -> Int {
        // 带参数
        let value = perform(action: NicooRouterManager.kSelector4, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNameSpace, withParams: params)
        guard let int = value as? Int else {
            return 0
        }
        return int
    }
    public func getImage() -> UIImage? {
        let value = perform(action: NicooRouterManager.kSelector5, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNameSpace, withParams: nil)
        guard let image = value as? UIImage else {
            return nil
        }
        return image
    }
    
}
