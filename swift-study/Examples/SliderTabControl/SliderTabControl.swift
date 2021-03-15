//
//  SliderTabControl.swift
//  swift-study
//
//  Created by 永平 on 2021/3/11.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class SliderTabControl: UIView {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var indicatorView: UILabel? // 底部指示器
    
    private var items: [PageItem] = []
    private var uiConfig: UIConfig!
    
    private var itemSelectedClousure: ((_ index: Int) -> Void)?
    private var numberOfTabsClousure: (() -> Int)?
    private var titleForTabIndexClousure: ((_ index: Int) -> String)?
    
    // 当前选中的项
    private var currentSelectedIndex: Int = -1
    
    init(uiConfig: UIConfig = UIConfig()) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        self.uiConfig = uiConfig
        
        scrollView = UIScrollView()
            .jcs_hideBothScrollIndicator()
            .jcs_layout(superView: self, layout: { (make) in
            make.left.top.right.height.equalToSuperview()
        })
        contentView = UIView().jcs_layout(superView: scrollView, layout: { (make) in
            make.left.top.height.right.equalToSuperview()
            make.width.equalTo(0)
        })
        if uiConfig.indicatorViewHidden == false{
            indicatorView = UILabel().jcs_backgroundColor(uiConfig.indicatorViewColor)
                .jcs_cornerRadius( uiConfig.indicatorViewShowCorner ? uiConfig.indicatorViewHeight / 2 : 0)
                .jcs_layout(superView: contentView, layout: { (make) in
                    make.height.equalTo(uiConfig.indicatorViewHeight)
                    make.width.equalTo(uiConfig.indicatorViewWidth)
                    make.left.equalTo(0)
                    make.bottom.equalTo(uiConfig.indicatorViewBottom)
                })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchToItem(willSelectedIndex: Int) {
        guard let lastItem = items.last, currentSelectedIndex != willSelectedIndex else {
            return
        }
        
        itemSelectedClousure?(willSelectedIndex)
        
        let currentSelectedButton = items[currentSelectedIndex]
        let willSelectedButton = items[willSelectedIndex]
        currentSelectedIndex = willSelectedIndex
        
        // 动画移动指示器
        indicatorView?.snp.updateConstraints { (make) in
            make.left.equalTo(willSelectedButton.frame.midX - self.uiConfig.indicatorViewWidth / 2)
        }
        
        // 字体动画切换
        UIView.animate(withDuration: 0.25) {
            currentSelectedButton.isSelected = false
            willSelectedButton.isSelected = true
            self.indicatorView?.superview?.layoutIfNeeded()
        }
        
        // 动画改变选择项的位置, 使其尽量靠近容器中间
        if (willSelectedButton.frame.midX < self.frame.midX) || (lastItem.frame.maxX < self.frame.width){
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        } else if ((contentView.frame.width - willSelectedButton.frame.midX) < self.frame.midX) {
            self.scrollView.setContentOffset(CGPoint(x: contentView.frame.width - self.frame.width, y: 0), animated: true)
        } else {
            let willButtonFrameInSelf = self.convert(willSelectedButton.frame, from: self.contentView)
            var currentOffset = self.scrollView.contentOffset
            currentOffset.x = currentOffset.x + (willButtonFrameInSelf.midX - self.frame.midX)
            self.scrollView.setContentOffset(currentOffset, animated: true)
        }
    }
    
    func reloadData() {
        guard let numberOfTabsClousure = numberOfTabsClousure,
              let titleForTabIndexClousure = titleForTabIndexClousure else { return }
        let tabCount = numberOfTabsClousure()
        guard tabCount > 0 else { return }
    
        // 清除原有数据
        items.forEach { (item) in
            item.removeFromSuperview()
        }
        items.removeAll()
        
        // 循环添加项目
        var totalWidth: CGFloat = 0
        for index in 0 ..< tabCount {
            let title = titleForTabIndexClousure(index)
            let itemButton = PageItem(title: title,
                                      normalFont: uiConfig.normalTextFont,
                                      selectedFont: uiConfig.selectedTextFont,
                                      normalColor: uiConfig.normalTextColor,
                                      selectedColor: uiConfig.selectedTextColor)
                .jcs_click { [weak self] sender in
                    self?.switchToItem(willSelectedIndex: index)
                }
            
            itemButton.jcs_layout(superView: contentView) { (make) in
                make.top.bottom.equalTo(0)
                make.width.equalTo(itemButton.normalWidth)
                make.left.equalTo(totalWidth)
            }
            items.append(itemButton)
            totalWidth = totalWidth + itemButton.normalWidth
        }
        
        contentView.snp.updateConstraints { (make) in
            make.width.equalTo(totalWidth)
        }
        
        // 默认选中第一个
        if let firstItemButton = items.first {
            indicatorView?.snp.updateConstraints { (make) in
                make.left.equalTo((firstItemButton.normalWidth - uiConfig.indicatorViewWidth) / 2)
            }
            currentSelectedIndex = 0
            firstItemButton.isSelected = true
            itemSelectedClousure?(0)
        }
    }
}

extension SliderTabControl {
    @discardableResult func jcs_numberOfTabs(closures: @escaping () -> Int) -> Self {
        numberOfTabsClousure = closures
        return self
    }
    @discardableResult func jcs_titleForTabIndex(closures: @escaping (_ index: Int) -> String) -> Self {
        titleForTabIndexClousure = closures
        return self
    }
    @discardableResult func jcs_itemSelectedClousure(closures: @escaping (_ index: Int) -> Void) -> Self {
        itemSelectedClousure = closures
        return self
    }
}

extension SliderTabControl {
    // UI 样式
    class UIConfig {
        var normalTextColor: UIColor = .black
        var selectedTextColor: UIColor = .black
        var normalTextFont: UIFont = .systemFont(ofSize: 16)
        var selectedTextFont: UIFont = .systemFont(ofSize: 22)
        
        /// 指示器是否显示圆角
        var indicatorViewHidden: Bool = false
        var indicatorViewShowCorner: Bool = true
        var indicatorViewColor: UIColor = .red
        var indicatorViewWidth: CGFloat = 15
        var indicatorViewHeight: CGFloat = 3
        var indicatorViewBottom: CGFloat = -3
    }
    
    class PageItem: UIView {
        var titleLabel: UILabel!
        private var normalFont: UIFont!
        private var selectedFont: UIFont!
        private var normalColor: UIColor!
        private var selectedColor: UIColor!
        private var transRatio: CGFloat = 1
        
        var isSelected: Bool = false {
            didSet {
                titleLabel.jcs_textColor(isSelected ? selectedColor : normalColor)
                if isSelected {
                    titleLabel.transform = CGAffineTransform(scaleX: transRatio, y: transRatio)
                } else {
                    titleLabel.transform = CGAffineTransform.identity
                }
            }
        }
        
        lazy var normalWidth: CGFloat = {
            if let text = titleLabel.text, let normalFont = normalFont {
                return NSString(string: text).boundingRect(with: CGSize(width: 100, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : normalFont], context: nil).width + 20
            }
            return 0
        }()
        lazy var selectedWidth: CGFloat = {
            if let text = titleLabel.text, let selectedFont = selectedFont {
                return NSString(string: text).boundingRect(with: CGSize(width: 100, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : selectedFont], context: nil).width + 20
            }
            return 0
        }()
        
        convenience init(title: String, normalFont: UIFont, selectedFont: UIFont, normalColor: UIColor, selectedColor: UIColor) {
            self.init(frame: .zero)
            titleLabel = UILabel(text: title, font: normalFont, color: normalColor)
                .jcs_textAlignment_Center()
                .jcs_layout(superView: self, layout: { (make) in
                    make.centerX.equalTo(self)
                    make.bottom.equalTo(-8)
                })
            self.normalFont = normalFont
            self.selectedFont = selectedFont
            self.normalColor = normalColor
            self.selectedColor = selectedColor
            
            let anchorY = normalFont.ascender / (normalFont.lineHeight - normalFont.leading)
            titleLabel.layer.anchorPoint = CGPoint(x: 0.5, y: anchorY)
            
            transRatio = selectedFont.pointSize / normalFont.pointSize
        }
    }
}
