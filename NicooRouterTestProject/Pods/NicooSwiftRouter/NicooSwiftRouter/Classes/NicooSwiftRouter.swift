//
//  NicooSwiftRouter.swift
//  NicooSwiftRouter
//
//  Created by 小星星 on 2018/7/6.
//

import Foundation

public struct NicooRouterManager {
    
    public static var schemes: [String]?
}
open class NicooRouter {
    public static let shareInstance = NicooRouter()
    
    private init() {}
    
    /// 通过远程调用程序入口
    ///
    /// - Parameters:
    ///   - url: 调用链接（链接模版：”[scheme:]//[target]/[action]?key1=value1,key2=value2“ ，scheme用于认证谁有权限打开这个app，并且将其作为target所在的namespace使用，可以设置白名单）
    ///   - completion: 完成调用的回调
    public func performAction(url: URL, completion: (([String: Any]?) -> Void)?) -> Any? {
        var params: [String: String]?
        if let paramsStr = url.query {
            params = [:]
            for param in paramsStr.components(separatedBy: "&") {
                let array = param.components(separatedBy: "=")
                if array.count != 2 { continue }
                params![array[0]] = array[1]
            }
        }
        
        // 防止攻击
        guard let scheme = url.scheme else {
            return false
        }
        guard let schemes = NicooRouterManager.schemes , schemes.contains(scheme) else {
            return false
        }
        let actionName = url.path.replacingOccurrences(of: "/", with: "")
        if actionName.hasPrefix("native") {
            return false
        }
        
        let targetName = url.host
        let result = perform(action: actionName, onTarget: targetName, inNamespace: scheme, withParams: params)
        if result != nil {
            completion?(["result": result!])
        } else {
            completion?(nil)
        }
        return result
    }
    
    /// 私有组件通信入口
    ///
    /// - Parameters:
    ///   - action: 需要调用的方法名（程序action函数命名规范为：@objc func action_actionName(...),action的方法必须使用@objc申明）
    ///   - target: action提供者（简单来说，即是类名，类的命名规范为Target_模块名，并且target需要继承NSObject）
    ///   - params: 参数（使用[String: Any?]来封装参数，可以包含任意个数和任意类型的参数）
    /// - Returns: 返回任意类型的数据（主要根据action本身的返回类型来定义的）
    public func perform(action: String?, onTarget target: String?, inNamespace namespace: String, withParams params: [String: Any]?) -> Any? {
        let aActionWithParam = Selector("Action_\(action ?? ""):")
        let aActionWithoutParam = Selector("Action_\(action ?? "")")
        
        let targetClassString = "\(namespace).Target_\(target!)"
        guard let targetClass = NSClassFromString(targetClassString) as? NSObject.Type else {
            return errorRequest(target: nil, params: params)
        }
        let aTarget = targetClass.init()
        if aTarget.responds(to: aActionWithParam) {
            let result = aTarget.perform(aActionWithParam, with: params)
            return safeRetrun(result, target:aTarget, sel: aActionWithParam)
            
        } else if aTarget.responds(to: aActionWithoutParam) {
            let result = aTarget.perform(aActionWithoutParam, with: nil)
            return safeRetrun(result, target:aTarget, sel: aActionWithoutParam)
            
        } else if aTarget.classForCoder.responds(to: aActionWithParam) {
            let result = (aTarget.classForCoder as! NSObject.Type).perform(aActionWithParam, with: params)
            return safeRetrun(result, target:aTarget, sel: aActionWithParam)
            
        } else if aTarget.classForCoder.responds(to: aActionWithoutParam) {
            let result = (aTarget.classForCoder as! NSObject.Type).perform(aActionWithoutParam, with: nil)
            return safeRetrun(result, target:aTarget, sel: aActionWithoutParam)
        }
        return errorRequest(target: aTarget, params: params)
    }
    
    // MARK: - Private funcs
    
    /// 针对没有寻找到对应action或者target，做容错处理
    ///
    /// - Parameters:
    ///   - action: actionName
    ///   - target: targetName
    ///   - params: 参数
    /// - Returns: 自定义返回结果
    private func errorRequest(target: NSObject?, params: [String: Any]?) -> Any? {
        let notFountAction = NSSelectorFromString("noResponse:")
        if target != nil && target!.responds(to: notFountAction) {
            let result = target!.perform(notFountAction, with: params)
            return safeRetrun(result, target:target!, sel: notFountAction)
        }
        return nil
    }
    
    /**
     根据函数返回类型，来安全的返回应该返回的数据。
     在oc中，我们可以通过 @encode(Void)这种类型编码来直观的对比函数的返回值，但是swift没有这样的方法，
     所以这里只能写hard code了。下面是对不同返回值的例举：
     Void -> v
     Int -> q
     Int8 -> c (char)
     Int16 -> s (short)
     Int32 -> i (int)
     Int64 -> q
     NSInteger -> q
     Float -> f
     Double -> d
     UnsafeMutablePointer<Int8>  -> *
     Any -> @
     AnyObject -> @
     [Int] -> @
     String -> @
     
     - parameter            result: 执行perform方法后返回的Unmanaged对象管理数据，需要进行解包。
     
     - parameter            target: 方法的承载者
     
     - parameter            sel: 方法
     
     - returns:             返回不同类型的返回值
     */
    private func safeRetrun(_ result: Unmanaged<AnyObject>?, target: NSObject, sel: Selector) -> Any? {
        return result?.takeUnretainedValue()
        /*
         var aMethod: Method?
         if target.responds(to: sel) {
         aMethod = class_getInstanceMethod(target.classForCoder, sel)
         } else if (target.classForCoder).responds(to: sel) {
         aMethod = class_getClassMethod(target.classForCoder, sel)
         }
         guard let method = aMethod else {
         return nil
         }
         let returnType = method_copyReturnType(method)
         let typeString = String(utf8String: returnType)!
         */
    }
}
