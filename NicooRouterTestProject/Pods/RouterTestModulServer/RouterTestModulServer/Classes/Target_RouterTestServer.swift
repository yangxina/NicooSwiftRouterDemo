//
//  Target_RouterTestServer.swift
//  Pods
//
//  Created by 小星星 on 2018/10/29.
//

import Foundation
import NicooSwiftRouter

/**  这个组件 实际上是从RouterTestModule 分离出来的，如果别的组件（如 RightMuneTabel）使用URL索引的方式调用RouterTestModule 中的方法, 则不需要这个组件。 但是URL的方式无法实现回调，所以 这个服务组件就存在了。此组件作为 “RouterTestModule” 的服务组件，别的组件依赖 此组件， 就可以通过 路由调用此组件内的Api 间接调用 “RouterTestModule” 中对外暴露的API。
 */

extension NicooRouterManager {
    fileprivate static let kNamespace = "RouterTestModule"
    fileprivate static let kTarget = "RouterLogin"
    fileprivate static let kPresentLoginVCAction = "persentLoginVC"
    fileprivate static let kGetUserInformation = "getUserInfoMsg"
}

extension NicooRouter {
    
    /// 暴露给其他组件 来 弹出登录控制器
    ///
    /// - Parameter finishedHandler: 登录回调,bool值true代表登录成功,false代表登录失败或者未登录
    
    public func Router_presentLoginViewController(_ finishedHandler: ((_ isLogin: Bool, _ userInfo: [String]?) -> Void)?) {
        var params = [String: Any]()
        params["loginFinishHandler"] = finishedHandler
        let _ = perform(action: NicooRouterManager.kPresentLoginVCAction, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNamespace, withParams: params)
    }
    
    /// 暴露给其他组件 来 获取用户信息的方法
    ///
    /// - Returns: 用户信息json
    public func Router_getUserInformation() -> [String: Any]? {
        let value = perform(action: NicooRouterManager.kGetUserInformation, onTarget: NicooRouterManager.kTarget, inNamespace: NicooRouterManager.kNamespace, withParams: nil)
        guard let userInfo = value as? [String: Any] else { return nil }
        return userInfo
    }
    
}

