//
//  RightMuneTable.swift
//  Pods-NicooRightMune_Example
//
//  Created by 小星星 on 2018/7/6.
//

import UIKit
import SnapKit

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
                self?.selectedIndex!(indexPath.row)
                self?.removeFromSuperview()
            }
        }
        return cell
    }
}

