//
//  LiveCommentVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/18.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit
import HandyJSON
import Kingfisher
import YYText

class LiveCommentVC: UIViewController {
    
    private var tableView: UITableView!
    private var tableViewBgView: ContainerTouchTroughView!
    private var bgView: UIImageView!
    
    private var comments: [LiveCommentModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.jcs_backgroundColor_White()
        
        bgView = UIImageView()
            .jcs_image(image: UIImage(named: "living_lianmai_bg"))
                .jcs_layout(superView: self) { (make) in
                make.left.top.right.bottom.equalToSuperview()
            }
        
            JCSNavigationBar(title: "评论") { [weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            .jcs_layout(superView: self) { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.height.equalTo(44)
            }
        
        tableViewBgView = ContainerTouchTroughView()
            .jcs_layout(superView: self, layout: { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(self.view).multipliedBy(0.5)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            })
            .jcs_backgroundColor_Clear()
    
        tableView = UITableView()
            .jcs_separatorStyle(.none)
            .jcs_allowsSelection(false)
            .jcs_hideBothScrollIndicator()
            .jcs_backgroundColor_Clear()
            .jcs_registerCellClass(LiveCommentCell.self, identifier: "cell")
            .jcs_dataSource(self)
            .jcs_delegate(self)
            .jcs_layout(superView: tableViewBgView, layout: { (make) in
                make.left.top.right.bottom.equalToSuperview()
            })
    
        
//        http://static.devjackcat.com/guizu_icon_zhizun_big%402x.png
//        http://static.devjackcat.com/icon_zhizun%402x.png
//
//        http://static.devjackcat.com/guizu_icon_zijue_big%402x.png
//        http://static.devjackcat.com/icon_zijue%402x.png
//
//        http://static.devjackcat.com/guizu_icon_nanjue_big%402x.png
//        http://static.devjackcat.com/icon_nanjue%402x.png
//
//        http://static.devjackcat.com/guizu_icon_guowang_big%402x.png
//        http://static.devjackcat.com/icon_guowang%402x.png
//
//        http://static.devjackcat.com/guizu_icon_houjue_big%402x.png
//        http://static.devjackcat.com/icon_houjue%402x.png
//
//        http://static.devjackcat.com/guizu_icon_bojue_big%402x.png
//        http://static.devjackcat.com/icon_bojue%402x.png
//
//        http://static.devjackcat.com/guizu_icon_huangdi%402x.png
//        http://static.devjackcat.com/icon_huangdi%402x.png
//
//        http://static.devjackcat.com/guizu_icon_gongjue_big%402x.png
//        http://static.devjackcat.com/icon_gongjue%402x.png
        
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_zhizun_big%402x.png",
                                         smallIcon: "icon_zhizun", //http://static.devjackcat.com/icon_zhizun%402x.png",
                                         avatar: "guizu_icon_zhizun_big", //"http://static.devjackcat.com/guizu_icon_zhizun_big%402x.png",
                                         content: "<font color=\"#DDDDDD\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 15))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_zijue_big%402x.png",
                                         smallIcon: "icon_zijue", //"http://static.devjackcat.com/icon_zijue%402x.png",
                                         avatar: nil, //"http://static.devjackcat.com/guizu_icon_zijue_big%402x.png",
                                         content: "<font color=\"#CDC9F6\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 11,
                                         borderColor: "#BBBBBB"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_nanjue_big%402x.png",
                                         smallIcon: "icon_nanjue", //"http://static.devjackcat.com/icon_nanjue%402x.png",
                                         avatar: "guizu_icon_nanjue_big", //"http://static.devjackcat.com/guizu_icon_nanjue_big%402x.png",
                                         content: "<font color=\"#6BD9D7\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 9,
                                         borderColor: "#7BE2E0"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_guowang_big%402x.png",
                                         smallIcon: nil, //"http://static.devjackcat.com/icon_guowang%402x.png",
                                         avatar: "guizu_icon_guowang_big", //"http://static.devjackcat.com/guizu_icon_guowang_big%402x.png",
                                         content: "<font color=\"#E9A262\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 5,
                                         borderColor: "#EEAF77"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_bojue_big%402x.png",
                                         smallIcon: "icon_bojue", //"http://static.devjackcat.com/icon_bojue%402x.png",
                                         avatar: "guizu_icon_bojue_big", //http://static.devjackcat.com/guizu_icon_bojue_big%402x.png",
                                         content: "<font color=\"#64A1F4\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 0,
                                         borderColor: "#99CEFF"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_huangdi%402x.png",
                                         smallIcon: "icon_huangdi", //"http://static.devjackcat.com/icon_huangdi%402x.png",
                                         avatar: nil, //"http://static.devjackcat.com/guizu_icon_huangdi%402x.png",
                                         content: "<font color=\"#ED7DFB\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font><font color=\"#ED7DFB\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 12,
                                         borderColor: "#EF8CFB"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_gongjue_big%402x.png",
                                         smallIcon: "icon_gongjue",  //http://static.devjackcat.com/icon_gongjue%402x.png",
                                         avatar: "guizu_icon_gongjue_big", //"http://static.devjackcat.com/guizu_icon_gongjue_big%402x.png",
                                         content: "<font color=\"#F0384E\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 0,
                                         bgImage: "huangdi_bg"))
        comments.append(LiveCommentModel(icon: "http://static.devjackcat.com/guizu_icon_houjue_big%402x.png",
                                         smallIcon: "icon_houjue", //"http://static.devjackcat.com/icon_houjue%402x.png",
                                         avatar: "guizu_icon_houjue_big", //"http://static.devjackcat.com/guizu_icon_houjue_big%402x.png",
                                         content: "<font color=\"#FFE869\" style=\"text-shadow: 2pt 2pt 5pt #FFE869;\">最佳脑残粉：</font><font color=\"#FFFFFF\">主播今天太漂亮了，播比平时晚了啊</font>",
                                         level: 0,
                                         bgImage: "zhizun_bg"))
        
        tableView.reloadData()
        
        KingfisherManager.shared.rx.retrieveImage(url: "http://static.devjackcat.com/guizu_icon_houjue_big%402x.png1")
            .subscribe { [weak self] (image) in
                self?.bgView.image = image
            } onError: { (error) in
                print("---下载图片 error = \(error)")
            }
            .disposing(with: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 顶部模糊背景
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: -100, y: 0, width: tableViewBgView.bounds.width + 200, height: tableViewBgView.bounds.height + 10)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0, NSNumber(value: 50.0 / Double(gradientLayer.frame.height)), NSNumber(value: Double(tableViewBgView.bounds.height / gradientLayer.frame.height)), 1]
        tableViewBgView.layer.mask = gradientLayer
    }
}

extension LiveCommentVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LiveCommentCell {
            cell.setup(model: comments[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return comments[indexPath.item].getCellHeight(maxWidth: self.view.bounds.size.width - 64 - 16)
    }
}

private class LiveCommentCell: UITableViewCell {
    private var iconIV: UIImageView!
    private var contentLabel: YYLabel!
    private var cornerContentView: UIView!
    private var backgroundImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        jcs_backgroundColor_Clear()
        contentView.jcs_backgroundColor_Clear()
        
        cornerContentView = UIView().jcs_layout(superView: self) { (make) in
            make.leading.equalTo(8)
            make.top.equalTo(5)
            make.trailing.equalTo(-8)
            make.bottom.equalTo(-5)
        }
        .jcs_backgroundColor(0x000000,alpha: 0.3)
        .jcs_cornerRadius(8)
        
        backgroundImageView = UIImageView()
            .jcs_layout(superView: self.contentView, layout: { (make) in
                make.left.equalTo(3)
                make.top.equalTo(0)
                make.right.equalTo(-3)
                make.bottom.equalTo(0)
            })
        
        iconIV = UIImageView()
            .jcs_layout(superView: cornerContentView, layout: { (make) in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(40)
                make.leading.equalTo(8)
            })
        
        contentLabel = YYLabel()
            .jcs_layout(superView: cornerContentView, layout: { (make) in
                make.leading.equalTo(56)
                make.trailing.equalTo(-8)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
            })
        contentLabel.numberOfLines = 0
        contentLabel.displaysAsynchronously = true
        contentLabel.ignoreCommonProperties = true
        contentLabel.layer.contents = nil
        contentLabel.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: LiveCommentModel) {
        if let icon = model.icon, let iconUrl = URL(string: icon) {
            iconIV.kf.setImage(with: iconUrl)
        }
        
        if let bgImage = model.bgImage, let image = UIImage(named: bgImage) {
            cornerContentView.jcs_backgroundColor(0x000000,alpha: 0)
            backgroundImageView.isHidden = false
            backgroundImageView.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 50 - 10, bottom: 23, right: 55 - 10), resizingMode: .stretch)
        } else {
            backgroundImageView.isHidden = true
            cornerContentView.jcs_backgroundColor(0x000000,alpha: 0.3)
            if let borderColor = model.getBorderColor() {
                cornerContentView.layer.borderColor = borderColor.cgColor
                cornerContentView.layer.borderWidth = 1
            } else {
                cornerContentView.layer.borderWidth = 0
            }
        }
        contentLabel.textLayout = model.cachedLayout
    }
}

private class LiveCommentModel: HandyJSON{
    required init() {
        
    }
    
    var icon: String?
    var smallIcon: String?
    var avatar: String?
    var content: String = ""
    var level: Int = 0
    var borderColor: String?
    var bgImage: String?
    
    private var cellHeight: CGFloat = 0
    private var attributeString: NSAttributedString?
    private(set) var cachedLayout: YYTextLayout?
    
    convenience init(icon: String? = nil, smallIcon: String? = nil, avatar: String? = nil, content: String = "", level: Int = 0, borderColor: String? = nil, bgImage: String? = nil) {
        self.init()
        self.icon = icon
        self.smallIcon = smallIcon
        self.avatar = avatar
        self.level = level
        self.content = content
        self.borderColor = borderColor
        self.bgImage = bgImage
    }
    
    func getBorderColor() -> UIColor? {
        if let borderColor = borderColor, borderColor.isEmpty == false {
            return UIColor(hexString: borderColor)
        } else {
            return nil
        }
    }
}

extension LiveCommentModel {
    func getAttributeString() -> NSAttributedString? {
        
        if let attributeString = attributeString {
            return attributeString
        }
        let attr = NSMutableAttributedString()
        if let contentAttr = HTMLAttribtuedStringConverter.HTML2AttributedString(content) {
            attr.append(contentAttr)
        }
            
        if let smallIcon = smallIcon, let icon = UIImage(named: smallIcon) {
            let attachment = TextAttachmentTool.makeNobleIcon(icon: icon)
            attr.insert(NSAttributedString(string: " "), at: 0)
            attr.insert(attachment, at: 0)
        }
        
        if let avatar = avatar, let avatarImage = UIImage(named: avatar) {
            let attachment = TextAttachmentTool.makeAvatarIcon(icon: avatarImage)
            attr.insert(NSAttributedString(string: " "), at: 0)
            attr.insert(attachment, at: 0)
        }
        
        if level > 0 {
            let attachment = TextAttachmentTool.makeVipLevelIcon(level: level)
            attr.insert(NSAttributedString(string: " "), at: 0)
            attr.insert(attachment, at: 0)
        }
        
        let attachment = TextAttachmentTool.makeWebImage()
        attr.insert(NSAttributedString(string: " "), at: 0)
        attr.insert(attachment, at: 0)
        
        attributeString = attr
        return attributeString
    }
    
    func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        if cellHeight > 0 {
            return cellHeight
        }
        
        if let attributeString = getAttributeString() {
            guard let layout = YYTextLayout(containerSize: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), text: attributeString) else {
                return 0
            }
            let size = CGSize(width: maxWidth, height: ceil(layout.textBoundingSize.height + 10 + 10))
            cachedLayout = layout
            cellHeight = max(55, size.height)
        }
        
        return cellHeight
    }
}

class TextAttachmentTool {
    /// 构建贵族勋章
    static func makeNobleIcon(icon: UIImage) -> NSAttributedString {
//        let attachment = NSTextAttachment()
//        attachment.image = icon
//        attachment.bounds = CGRect(x: 0, y: -4, width: 41, height: 21)
//        return attachment
        
        let size = CGSize(width: 41, height: 21)
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.contents = icon.cgImage
        return NSAttributedString.yy_attachmentString(withContent: layer, contentMode: UIView.ContentMode.center, attachmentSize: size, alignTo: .systemFont(ofSize: 15), alignment: .center)
    }
    /// 构建贵族勋章
    static func makeAvatarIcon(icon: UIImage) -> NSAttributedString {
//        let attachment = NSTextAttachment()
//        attachment.image = icon
//        attachment.bounds = CGRect(x: 0, y: -4, width: 21, height: 21)
//        return attachment
        
        let size = CGSize(width: 21, height: 21)
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.contents = icon.cgImage
        return NSAttributedString.yy_attachmentString(withContent: layer, contentMode: UIView.ContentMode.center, attachmentSize: size, alignTo: .systemFont(ofSize: 15), alignment: .center)
    }
    /// 构建贵族勋章
    static func makeVipLevelIcon(level: Int) -> NSAttributedString {
        let height: CGFloat = 24
        let levelView = LiveVipLevelView(frame: CGRect(x: 0, y: 0, width: 60, height: height)).jcs_cornerRadius(4)
        levelView.level = level
        
        UIGraphicsBeginImageContextWithOptions(levelView.bounds.size, false, UIScreen.main.scale)
        levelView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
//        let attachment = NSTextAttachment()
//        attachment.image = image
//        attachment.bounds = CGRect(x: 0, y: 0, width: levelView.bounds.width / 2, height: levelView.bounds.height / 2)
//        return attachment
        
        let size = CGSize(width: 30, height: height / 2)
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.contents = image?.cgImage
        return NSAttributedString.yy_attachmentString(withContent: layer, contentMode: UIView.ContentMode.center, attachmentSize: size, alignTo: .systemFont(ofSize: 15), alignment: .center)
    }
    
    /// 构建贵族勋章
    static func makeWebImage() -> NSAttributedString {
        
        let width = 21
        let height = 21
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        delay(5) {
            if let url = URL(string: "http://static.devjackcat.com/huajian/flower.png") {
                imageView.kf.setImage(with: url)
            }
        }
        
        return NSAttributedString.yy_attachmentString(withContent: imageView, contentMode: UIView.ContentMode.center, attachmentSize: CGSize(width: width, height: height), alignTo: .systemFont(ofSize: 15), alignment: .center)
    }
}
