//
//  RightMuneTable.swift
//  Pods-NicooRightMune_Example
//
//  Created by 小星星 on 2018/7/6.
//

import UIKit
import SnapKit
import NicooSwiftRouter
import RouterTestModulServer

open class RightMuneTable: UIView {
    
    static let selfTag = 9999999
    static let reuseId = "muneListCell"
    ///背景图片的比例，防止变形严重
    static let scale = CGFloat(0.83461538)
    /// 注意： 两个菜单或以上才能使用图片，谢谢，两个以下的才当不能使用图片
    public var imageSource: [UIImage]?
    public var titleSource: [String]?
    lazy var seletedBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    public var selectedIndex:((_ index: Int) -> Void)?
    
    fileprivate lazy var arrowDownImage: UIImageView = {
        let image = UIImageView(image: SourceBoudleManager.foundImage(imageName:"muneBg"))
        image.backgroundColor = UIColor.clear
        image.layer.cornerRadius = 10
        image.contentMode = UIViewContentMode.scaleToFill
        image.isUserInteractionEnabled = true
        return image
    }()
    fileprivate lazy var muneTable: UITableView = {
        let table = UITableView(frame: self.bounds, style: .plain)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.backgroundColor = UIColor.clear
        table.isScrollEnabled = false
        table.backgroundView = arrowDownImage
        table.layer.masksToBounds = true
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    deinit {
        
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = RightMuneTable.selfTag
        loadMuneTable()
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSelftoSuperView(_ view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if let  titles = titleSource, titles.count > 0 {
            let tableHeight = titles.count * 33 + 30
            updateLayoutOfTable(CGFloat(tableHeight))
            muneTable.reloadData()
        }
    }
    
    public  func showInView(_ view: UIView) {
        if let viewself = view.viewWithTag(RightMuneTable.selfTag) {
            viewself.removeFromSuperview()
        } else {
            addSelftoSuperView(view)
        }
    }
    private func loadMuneTable() {
        addSubview(muneTable)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 108.5, height: 18))
        headerView.backgroundColor = UIColor.clear
        muneTable.tableHeaderView = headerView
        muneTable.register(RightMuneTableCell.classForCoder(), forCellReuseIdentifier: RightMuneTable.reuseId)
        layoutAllSubviews(130)
        
    }
    private func layoutAllSubviews(_ height: CGFloat) {
        muneTable.snp.makeConstraints { (make) in
            make.trailing.equalTo(-8)
            make.top.equalTo(-3)
            make.height.equalTo(height)
            make.width.equalTo(height * RightMuneTable.scale)
        }
        
    }
    private func updateLayoutOfTable(_ height: CGFloat) {
        muneTable.snp.updateConstraints() { (make) in
            make.height.equalTo(height)
            make.width.equalTo( height >= 96 ? 108.5 : height * RightMuneTable.scale)
        }
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
}
extension RightMuneTable: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleSource?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RightMuneTable.reuseId, for: indexPath) as? RightMuneTableCell else {
            return UITableViewCell()
        }
        cell.selectedBackgroundView = seletedBgView
        cell.configCell(imageSource?[indexPath.row], titleSource?[indexPath.row])
        cell.selectedBlock = { [weak self]  in
            if self?.selectedIndex != nil {
                if let login = self?.islogin(), login {
                    // 已经登录
                    print("isloginStatu =\(login)")
                    self?.getUserInfo()
                } else {
                    // 未登录
                    print("isloginStatu = false,或nil  去登陆")
                    self?.persentLoginVC()
                }
                self?.selectedIndex!(indexPath.row)
                self?.removeFromSuperview()
            }
        }
        return cell
    }
}

extension RightMuneTable {
    
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
    
    
    /// 通过组件 RouterTestModule 提供的服务组件： RouterTestModulServer  来调用 RouterTestModule 中的登录页面和登录功能, 由于需要回调，并且个人觉得用URL调用的方式， 没有这种方式好。
    func persentLoginVC() {
        NicooRouter.shareInstance.Router_presentLoginViewController { (isLogin, userInfo) in
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
    }
    
    /// 获取用户信息
    func getUserInfo() {
        if let userInfo = NicooRouter.shareInstance.Router_getUserInformation() {
            print("getUserInfo == \(userInfo)")
        }
    }
    
}


extension UIViewController {
    
    func showErrorMessage(_ message: String, cancelHandler: (() -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            cancelHandler?()
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    class func currentViewController(_ baseVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = baseVC as? UINavigationController {
            return currentViewController(nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            return currentViewController(tab.selectedViewController)
        }
        if let presented = baseVC?.presentedViewController {
            return currentViewController(presented)
        }
        return baseVC
    }
    
}
