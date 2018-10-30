# RouterTestModulServer

[![CI Status](https://img.shields.io/travis/504672006@qq.com/RouterTestModulServer.svg?style=flat)](https://travis-ci.org/504672006@qq.com/RouterTestModulServer)
[![Version](https://img.shields.io/cocoapods/v/RouterTestModulServer.svg?style=flat)](https://cocoapods.org/pods/RouterTestModulServer)
[![License](https://img.shields.io/cocoapods/l/RouterTestModulServer.svg?style=flat)](https://cocoapods.org/pods/RouterTestModulServer)
[![Platform](https://img.shields.io/cocoapods/p/RouterTestModulServer.svg?style=flat)](https://cocoapods.org/pods/RouterTestModulServer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

    此组件，其实是为组件 “RouterTestModule” 提供服务的一个服务组件。它的作用是
    
    其他组件（如：“RightMuneTabel” 组件）依赖它之后，可以通过它调用 组件 “RouterTestModule” 对外提供的API，如下两个API： 
    
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
    
    实际项目中，所有需要对外暴露API的组件都可以在有一个专门为他服务的组件  “xxxServer” 组件，其他组件需要与 “xxx” 组件通信时，就直接依赖 “xxxServer” 组件。通过服务组件 “xxxServer” 调用 “xxx” 中对外暴露的 api.


## Installation

RouterTestModulServer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RouterTestModulServer'
```

## Author

504672006@qq.com, yangxin@tzpt.com

## License

RouterTestModulServer is available under the MIT license. See the LICENSE file for more info.
