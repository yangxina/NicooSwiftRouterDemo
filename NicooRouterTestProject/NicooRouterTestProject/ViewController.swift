//
//  ViewController.swift
//  NicooRouterTestProject
//
//  Created by 小星星 on 2018/7/9.
//  Copyright © 2018年 yangxin. All rights reserved.
//

import UIKit
import RouterTestModule
import RightMuneTabel

class ViewController: UIViewController {
    
    static let cellId = "cellReuseId"

    @IBOutlet weak var imageViewss: UIImageView!
    @IBAction func gan(_ sender: UIButton) {
        if sender.tag == 1 {
            if let str = RouterTestClass.getMessageFormOtherModule(1) as? String {
                print("路由获取字符串 = \(str)")
            }
        }
        if sender.tag == 2 {
            if let strArray = RouterTestClass.getMessageFormOtherModule(2) as? [String] {
                print("路由获取字符串数组 = \(strArray)")
            }
        }
        if sender.tag == 3 {
            if let number = RouterTestClass.getMessageFormOtherModule(3) as? Int {
                print("路由获取基本数据类型 = \(number)")
            }
        }
        if sender.tag == 4 {
            if let numberArray = RouterTestClass.getMessageFormOtherModule(4) as? [Int] {
                print("路由获取组件信息 = \(numberArray)")
            }
        }
        if sender.tag == 5 {
            if let backimage = RouterTestClass.getMessageFormOtherModule(5) as? UIImage {
                self.imageViewss.image = backimage
            }
        }
    }
    
    lazy private var tableHeader: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 180))
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    lazy private var headerImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy private var infoMsgLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }()
    
    lazy private var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ViewController.cellId)
        return table
    }()
    
    let souceTitle = ["不带参数，获取String", "不带参数，获取数组", "带参数，获取基本数据类型", "不带参数获取UIImage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 7.0, *) {
            if self.responds(to:#selector(getter: edgesForExtendedLayout) ) {
                self.edgesForExtendedLayout = .bottom
            }
        }
        loadRightBarButton()
        view.addSubview(tableView)
        tableHeader.addSubview(headerImage)
        tableHeader.addSubview(infoMsgLable)
        tableView.tableHeaderView = tableHeader
        layoutPageSubviews()
        
    }
    
    private func loadRightBarButton() {
        let right = UIBarButtonItem(title: "show",  style: .plain, target: self, action: #selector(rightBarButtonClick))
        right.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.purple], for: .normal)
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func rightBarButtonClick() {
        //右上角菜单按钮
        let mune = RightMuneTable(frame: self.view.bounds)
        mune.imageSource = [UIImage(named: "collection"), UIImage(named: "downLoad"), UIImage(named: "shareAction"),UIImage(named: "collection")] as? [UIImage]
        mune.titleSource = ["收藏","下载","分享"]
        mune.selectedIndex = { [weak self] (index) in
            print("index = \(index)")
            if index == 1 {
               
                
            }else if index == 0 {
               
            }else {
                
            }
            
            
        }
        mune.showInView(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return souceTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellId, for: indexPath)
        cell.textLabel?.text = souceTitle[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if let str = RouterTestClass.getMessageFormOtherModule(1) as? String {
               infoMsgLable.text = str
            }
            break
        case 1:
            if let strArray = RouterTestClass.getMessageFormOtherModule(2) as? [String] {
                infoMsgLable.text = String(format: "%@", strArray)
            }
            break
        case 2:
            if let number = RouterTestClass.getMessageFormOtherModule(3) as? Int {
                infoMsgLable.text = "路由获取基本数据类型 = \(number)"
            }
            break
        case 3:
            if let backimage = RouterTestClass.getMessageFormOtherModule(5) as? UIImage {
                self.headerImage.image = backimage
            }
            break
        default:
            break
        }
    }
}


// MARK: - Layout
extension ViewController {
    
    private func layoutPageSubviews() {
        layoutTableView()
        layoutTableHeaderSubViews()
    }
    
    private func layoutTableView() {
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func layoutTableHeader() {
        tableHeader.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(tableView)
            make.height.equalTo(180)
        }
    }
    
    private func layoutTableHeaderSubViews() {
        headerImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(15)
            make.width.height.equalTo(60)
        }
        infoMsgLable.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(headerImage.snp.bottom).offset(10)
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
