# RightMuneTabel

[![CI Status](https://img.shields.io/travis/504672006@qq.com/RightMuneTabel.svg?style=flat)](https://travis-ci.org/504672006@qq.com/RightMuneTabel)
[![Version](https://img.shields.io/cocoapods/v/RightMuneTabel.svg?style=flat)](https://cocoapods.org/pods/RightMuneTabel)
[![License](https://img.shields.io/cocoapods/l/RightMuneTabel.svg?style=flat)](https://cocoapods.org/pods/RightMuneTabel)
[![Platform](https://img.shields.io/cocoapods/p/RightMuneTabel.svg?style=flat)](https://cocoapods.org/pods/RightMuneTabel)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
## How to Use

    1. //右上角菜单按钮

     let mune = RightMuneTable(frame: self.view.bounds)
     mune.imageSource = [UIImage(named: "collection"), UIImage(named: "downLoad"), UIImage(named: "shareAction")] as? [UIImage]
     mune.titleSource = ["收藏","下载","分享"] //,"分享","分享"
     mune.selectedIndex = { [weak self] (index) in
        if index == 1 { 
        
        }  
     } 
     mune.showInView(self.view)
     
     2. 这个组件的意义所在： 
     RightMuneTabel 组件 作为 路由组件 “NicooSwiftRouter” 的测试组件而存在。 当点击 RightMuneTable的 item 时，与组件 “RouterTestModule” 通讯，模拟在组件中点击 ”收藏“ ，”vip下载“ 之类的需要用户登录后才能执行的操作。
    


## Installation

RightMuneTabel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RightMuneTabel'
```

## Author

504672006@qq.com, yangxin@tzpt.com

## License

RightMuneTabel is available under the MIT license. See the LICENSE file for more info.
