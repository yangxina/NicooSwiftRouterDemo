//
//  LoginViewController.swift
//  RouterTestModule
//
//  Created by 小星星 on 2018/10/29.
//

import UIKit

/// 登录页面

class LoginViewController: UIViewController {
    
    private lazy var backButton: UIBarButtonItem = {
        let backBtn = UIBarButtonItem(title: "返回",  style: .plain, target: self, action: #selector(back))
        backBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.purple], for: .normal)
        navigationItem.leftBarButtonItem = backBtn
        return backBtn
    }()
    
    private lazy var userName: UITextField = {
        let usernameTf = UITextField(frame: CGRect(x: 30, y: 150, width: view.bounds.width - 60, height: 40))
        usernameTf.borderStyle = UITextBorderStyle.roundedRect
        usernameTf.placeholder = "请输入用户名"
        return usernameTf
    }()
    private lazy var userpsw: UITextField = {
        let userpswtf = UITextField(frame: CGRect(x: 30, y: 210, width: view.bounds.width - 60, height: 40))
        userpswtf.borderStyle = UITextBorderStyle.roundedRect
        userpswtf.placeholder = "请输入密码"
        return userpswtf
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("登 录", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.frame = CGRect(x: 30, y: 280, width: view.bounds.width - 60, height: 40)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    var loginFinishHandler:((_ isloginSuccess: Bool, _ userInfo: [String]?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = backButton
        view.addSubview(userName)
        view.addSubview(userpsw)
        view.addSubview(loginButton)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func login() {
        if userName.text != nil && !userName.text!.isEmpty && userpsw.text != nil && !userpsw.text!.isEmpty {
            // 登录成功
            loginFinishHandler?(true, [userName.text!, userpsw.text!])
            dismiss(animated: true, completion: nil)
        } else {
            // 登录失败
            loginFinishHandler?(false, nil)
            showErrorMessage("登录失败,账号密码不能为空！", cancelHandler: nil)
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
