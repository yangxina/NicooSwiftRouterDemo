//
//  Target_RouterLogin.swift
//  RouterTestModule
//
//  Created by 小星星 on 2018/10/29.
//

import Foundation

/// RouterTestModule 组件 对外暴露的 API
class Target_RouterLogin: NSObject {
    
    /// 调起登录页面 @objc func 这里的方法名必须和 暴露出去的server 中定义的 kPresentLoginVCAction 一致
    ///
    /// - Parameter successHandler: 登陆成功回调
    @objc func Action_persentLoginVC(_ params: [String: Any]?) {
        let finishedHandler = params?["loginFinishHandler"] as? ((Bool, [String]?) -> Void)
        let loginVC = LoginViewController()
        loginVC.loginFinishHandler = finishedHandler
        let nav = UINavigationController(rootViewController: loginVC)
        let vc =  UIViewController.currentViewController()
        vc?.present(nav, animated: true, completion: nil)
    }
    
    /// 获取用户信息， @objc func , 这里的方法名必须和 暴露出去的server 中定义的 kGetUserInformation 一致
    ///
    /// - Returns: 用户信息（这里必须是对象类型的返回值）
    @objc func Action_getUserInfoMsg() -> [String: Any]? {
        let userGeter = RouterTestClass()
        guard let userInfo = userGeter.getUserInfoMessage() else {
            return nil
        }
        return userInfo
    }
    
    /// 是否已登录 @objc func
    ///
    /// - Returns: isLogin
    @objc func Action_getLoginStatu() -> NSNumber {
        return 0
    }
}

