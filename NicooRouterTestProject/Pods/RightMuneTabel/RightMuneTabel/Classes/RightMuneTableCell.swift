//
//  RightMuneTableCell.swift
//  Pods-NicooRightMune_Example
//
//  Created by 小星星 on 2018/7/6.
//

import UIKit
import SnapKit
class RightMuneTableCell: UITableViewCell {

    var selectedBlock:(() -> Void)?
    
    lazy var imageV: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIViewContentMode.scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    lazy var titleMune: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        return lable
    }()
    lazy var fakeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(imageWithColor(UIColor.lightGray, CGRect(x: 0, y: 0, width: 109, height: 33)), for: .highlighted)
        button.addTarget(self, action: #selector(fakeButtonSelected), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadUI() {
        contentView.addSubview(fakeButton)
        contentView.addSubview(imageV)
        contentView.addSubview(titleMune)
        
        layoutAllSubviews()
    }
    func layoutAllSubviews() {
        imageV.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(17.5)
            make.width.equalTo(18)
        }
        titleMune.snp.makeConstraints { (make) in
            make.leading.equalTo(imageV.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        fakeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(3)
            make.trailing.equalTo(-3)
            make.top.bottom.equalToSuperview()
        }
    }
    func configCell(_ imageSource: UIImage?, _ titleSource: String?) {
        if let image = imageSource {
            imageV.image = image
            titleMune.textAlignment = .left
            imageV.snp.updateConstraints { (make) in
                make.width.equalTo(18)
                make.leading.equalTo(15)
            }
        } else {
            titleMune.textAlignment = .center
            imageV.snp.updateConstraints { (make) in
                make.width.equalTo(0)
                make.leading.equalTo(0)
            }
        }
        if let title = titleSource {
            titleMune.text = title
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func imageWithColor(_ color: UIColor, _ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    @objc func fakeButtonSelected() {
        if selectedBlock != nil {
            selectedBlock!()
        }
    }
}


