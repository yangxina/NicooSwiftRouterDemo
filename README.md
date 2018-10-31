## NicooSwiftRouterDemo

You can use the [editor on GitHub](https://github.com/yangxina/app/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### 不解释，直接上DEMO 

Demo看起来是有点绕，但是懂了比直接在路由组件内写  Demo更为直观。   NicooSwiftRouter 是基于Swift4.1写的组件通信的路由组件，参考了大神casa的OC版路由。 
路由组件地址：https://github.com/yangxina/NicooSwiftRouter
  
使用场景：

当在 组件A 内需要登录时， 而 “登录” 整个模块也是一个 组件B ，这时候就需要 组件A 通过路由器 
NicooSwiftRouter 去调用 组件B 内的登录功能， 获取是否已经登录，登录状态，或者用户信息等。

（有人说，可以直接A组件 依赖B组件， 但是这样整个项目中的组件的耦合性就太大，路由的作用就是实现组件间的通讯和解耦）
    
使用方法:

路由组件 “NicooSwiftRouter” 中，提供了两种组件通讯的方式。 
    
1. 通过远程调用程序入口
    通过 url: 调用链接, 链接模版：”[scheme:]//[target]/[action]?key1=value1,key2=value2“ 
    
    scheme:  用于认证谁有权限打开这个app，并且将其作为target所在的namespace使用，
    可以设置白名单
    
    target:  组件内提供给外部调用的API所在的文件名：如：”Target_RouterLogin“，
    ”NicooSwiftRouter“ 中自动添加了前缀 ”Target_”，url中的 [target] 不需要前缀。
    
    action:  "Target_XXX" 文件中的API方法名 如： Action_getRouterApiInt()  这里需要注意的是：
    （1）. url中 传递的 [action] 不需要加前缀 ”Action_“， 因为在路由器组件中会自动添加前缀。 
    （2）. "Target_XXX" 中的API 的方法必须使用 @objc 修饰， 并且带返回值的方法，
      返回值必须为对象类型。 基本数据类型 用 NSNumber 作为返回值， 在外部转换。
    组件中做了头部的 ”Target_“ 处理， 为了区分组件内 功能文件 和 路由API文件，
    项目中一眼就能看到为路由提供API的 ”Target_XXX“ 文件，这样使得开发时更清晰。
    
url 方式实例：（远程调用程序入口）
     
一.  假设我们需要 在demo 中的 RouterTestModule 组件内通过路由调用 RightMuneTabel 组件内的APi 

（前提是，这个组件提供了给路由调用的API）
    
    class Target_RouterApi 就是 RightMuneTabel 提供给路由调用的API的容器：
     比如这个API ： 这个方法是对外返回一个字符串。 
    
    // api 方法必须用@objc 修饰， 切返回时必须为对象类型
    @objc func Action_getRouterApiData() ->String {
          return SourceBoudleManager.retureString()
    }
    
我们可以在另外一个组件（RouterTestModule）内通过 Url 调用：
    
    let str = "RightMuneTabel://RouterApi/getRouterApiData"
    let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: utf8String)!
    guard let value =  shareToplatform(url) as? String  else {
    return "没成功"
    }
    
    // 将url 传给路由器，路由器通过url找到组件 RightMuneTabel 中对应的api
    class func shareToplatform(_ url: URL?) -> Any? {
        guard let shareUrl = url else {
           return ""
        }
        return NicooRouter.shareInstance.performAction(url: shareUrl , completion: nil)
    }
    
二.  假设我们需要在 RightMuneTabel 组件中 获取登录状态 （登录功能，和登录状态在组件 “RouterTestModule” 中）
    我们可以找到  RouterTestModule 组件中对外提供的API   （Target_RouterLogin 中）

    @objc func Action_getLoginStatu() -> NSNumber {
        return 0
    }
    
我们需要通过路由 和 url 路径 去调用它 ：
     
1. 获取 url 
     
       let str = "RouterTestModule://RouterLogin/getLoginStatu"
       let utf8String = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
       let url = URL(string: utf8String)!
       guard let islogin = shareToPlatform(url) as? Bool  else {
        return false
       }
    
2. 路由器通过url调用 getLoginStatu
    
       func shareToPlatform(_ url: URL?) -> Any? {
         guard let shareUrl = url else { return "" }
         return NicooRouter.shareInstance.performAction(url: shareUrl , completion: nil)
       }
    
 Server组件 方式实例：（私有组件通信入口）  
      
server组件是什么？ server组件 就是 一个组件 和 路由器 的中间桥梁。 比如上述的  url 方式中就不需要  server组件， 它可以直接通过URL 索引直接找到对应的API。 但是 url 方式有两个缺点：

      1. 当项目到后期，很多组件间都存在通讯， 互相调用的时候，url满天飞，非常不好管理。
      2. 假如我的组件A 调用组件B中的 api时需要一个block回调，此时url这种方式就明显的显得极为尴尬。
      （别的缺点因本人技术有限暂时还没发现）
      
举个例子：     
当在 组件A 内需要登录时， 而 “登录” 整个模块也是一个 组件B ，这时候就需要 组件A 通过路由器
调用 组件B 内的登录功能， 获取是否已经登录，登录状态，或者用户信息等 ，然后需要通过一个block回调给 组件A。   
这时候， server组件就派上用场了： 这也正是我们Demo中的例子: 
我们可以看到Demo中的 server组件内就是对路由器的一个扩展： 
     
      extension NicooRouterManager {
         /// 命名空间
         fileprivate static let kNamespace = "RouterTestModule"
         
         /// Target文件
         fileprivate static let kTarget = "RouterLogin"
         
         /// API name (不需要前缀， 因为在 NicooSwiftRouter 组件中，会自动添加 “Target_” 、 “Action_” 前缀)
         fileprivate static let kPresentLoginVCAction = "persentLoginVC"
         fileprivate static let kGetUserInformation = "getUserInfoMsg"
      }

上述代码是对当前server组件要调用的APi所在的 组件 RouterTestModule 的命名空间，
 API文件（Target文件） 以及API 方法名 ， 这里定义的方法名，必须和 组件 RouterTestModule 对外暴露的API 方法名一一对应。
 （不带前缀，前缀在路由器中会自动加上，但是API 方法体重必须有前缀， 这也是为了在开发中一眼就能看出 这是组件通讯的API方法）
      
下面便是 路由器的扩展： 其中提供了给其他组件调用的方法， 如果需要block回调，直接用 
      
       var params = [String: Any]()
       params["loginFinishHandler"] = finishedHandler
       
将block包装成参数，传递到组件 RouterTestModule 中， 
      
      
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
         let value = perform(action: NicooRouterManager.kGetUserInformation, onTarget: NicooRouterManager.kTarget,         inNamespace: NicooRouterManager.kNamespace, withParams: nil)
          guard let userInfo = value as? [String: Any] else { return nil }
          return userInfo
      }
    }
    
上述的路由拓展中的方法就是 给外部组件调用的。 外部组件只要依赖了路由和server组件， 就可以直接通过路由调用 server组件中的方法体，从而调起 RouterTestModule 组件中 Target_RouterLogin 内的API。
    
调用 ： 
    这里的调用就不需要通过URL 了， 直接使用路由调用 ： 
    
    NicooRouter.shareInstance.Router_presentLoginViewController 
    { (isLogin, userInfo) in
        if isLogin {
           print("登录成功 ----------->\n 账号：\(userInfo?[0]) \n 密码：\(userInfo?[1]) ")
          /// 获取用户信息
           if let userInfo = NicooRouter.shareInstance.Router_getUserInformation() {
               print("getUserInfo == \(userInfo)")
           }
        } else {
            print("登录失败")
        }
    }
    
具体的代码，请看Demo。  

## Installation

NicooSwiftRouter is available through[CocoaPods](https://cocoapods.org). To install

it, simply add the following line to your Podfile:

```ruby

pod 'NicooSwiftRouter'

```

## Author

504672006@qq.com, yangxin@tzpt.com

## License

NicooSwiftRouter is available under the MIT license. See the LICENSE file for more info.
   

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/yangxina/app/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
