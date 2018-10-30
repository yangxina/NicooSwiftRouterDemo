# RouterTestModule

[![CI Status](https://img.shields.io/travis/504672006@qq.com/RouterTestModule.svg?style=flat)](https://travis-ci.org/504672006@qq.com/RouterTestModule)
[![Version](https://img.shields.io/cocoapods/v/RouterTestModule.svg?style=flat)](https://cocoapods.org/pods/RouterTestModule)
[![License](https://img.shields.io/cocoapods/l/RouterTestModule.svg?style=flat)](https://cocoapods.org/pods/RouterTestModule)
[![Platform](https://img.shields.io/cocoapods/p/RouterTestModule.svg?style=flat)](https://cocoapods.org/pods/RouterTestModule)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

      这个组件也是为路由器准备的测试组件，3个文件： LoginViewController.swift / RouterTestClass.swift / Target_RouterLogin
      
      LoginViewController.swift : 登录页面  
      
      RouterTestClass.swift  : 通过URL 通过远程调用程序入口 的方式 调用 “RightMuneTable” 组件中 “Target_RouterApi” 提供的外部调用API。
      
      Target_RouterLogin.swift : 提供给外部组件调用的api. 例如： 外部想要获取登录状态：
      
      /// 通过 "RouterTestModule://RouterLogin/getLoginStatu" 索引URL去 RouterTestModule 组件内获取登录状态
      ///
      /// - Returns: 是否已经登录
      func islogin() -> Bool {
          let str = "RouterTestModule://RouterLogin/getLoginStatu"
          let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
          let url = URL(string: utf8String)!
          guard let islogin = shareToPlatform(url) as? Bool  else {
              return false
          }
          return islogin
      }
      
      /// 路由调用Url去调用方法，获取数据（当然也可以只是单纯的调用方法，没有返回值）
      ///
      /// - Parameter url: 另一组件的方法索引（swift中需带命名空间）
      /// - Returns: 返回值
      func shareToPlatform(_ url: URL?) -> Any? {
          guard let shareUrl = url else {
            return ""
          }
          return NicooRouter.shareInstance.performAction(url: shareUrl , completion: nil)
      }
      
       或者可以通过 server组件获取， 就像获取用户信息 和调用登录功能一样： 
       NicooRouter.shareInstance.Router_getUserInformation() 其中 Router_getUserInformation() API是 RouterTestModule 组件的 server组件， 外部通过 路由调用 Router_getUserInformation()， 即可间接调用到 Target_RouterLogin 中的  Action_getUserInfoMsg() Api.
       
       if let userInfo = NicooRouter.shareInstance.Router_getUserInformation() {
       print("getUserInfo == \(userInfo)")
       }
       
     
      
## Installation

RouterTestModule is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RouterTestModule'
```

## Author

504672006@qq.com, yangxin@tzpt.com

## License

RouterTestModule is available under the MIT license. See the LICENSE file for more info.
