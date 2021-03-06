//
//  SliderPageViewController.swift
//  swift-study
//
//  Created by 永平 on 2021/3/12.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class SliderPageViewController : UIViewController {
    
    private var sliderTab: SliderTabControl!
    private var containerScrollView: UIScrollView!
    private var contentView: UIView!
    
    // 是否第一次加载
    private var isFirstLoad: Bool = true
    private var titlesMap: [Int: String] = [Int: String]()
    private var viewControllersMap: [Int: UIViewController] = [Int: UIViewController]()
    
    // 是否正执行添加页面操作
    private var isAddingPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray

        sliderTab = SliderTabControl().jcs_layout(superView: self) { (make) in
                make.left.right.equalTo(0)
                make.top.equalTo(sliderTabTop())
                make.height.equalTo(50)
            }
            .jcs_numberOfTabs(closures: { [weak self] () -> Int in
                guard let self = self else { return 0 }
                return self.sliderPageCount()
            })
            .jcs_titleForTabIndex(closures: { [weak self] (index) -> String in
                guard let self = self else { return "" }
                if let title = self.titlesMap[index] {
                    return title
                }
                let title = self.sliderPageTitle(for: index)
                self.titlesMap[index] = title
                return title
            })
            .jcs_itemSelectedClousure(closures: { [weak self] (index) in
                guard let self = self else { return }
                _ = self.addPage(for: index)
            })
        
        containerScrollView = UIScrollView()
            .jcs_delegate(self)
            .jcs_pagingEnabled(true)
            .jcs_layout(superView: self, layout: { (make) in
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
                }
                make.left.right.equalTo(0)
                make.top.equalTo(sliderTab.snp.bottom)
            })
        contentView = UIView()
            .jcs_layout(superView: containerScrollView, layout: { (make) in
                make.left.top.height.right.equalToSuperview()
                make.width.equalTo(self.view.frame.width * CGFloat(self.sliderPageCount()))
            })
        
    }
    
    // 添加页面
    @discardableResult private func addPage(for index: Int) -> UIViewController? {
        guard isAddingPage == false else { return nil }
        isAddingPage = true
        
        // 初始化时不切换，其他都切换Tab
        if isFirstLoad == false {
            sliderTab.switchToItem(willSelectedIndex: index)
        }
        isFirstLoad = false
        
        // 优先读缓存
        if let vc = self.viewControllersMap[index] {
            isAddingPage = false
            // 已缓存，则切换过去
            containerScrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.frame.width, y: 0), animated: false)
            return vc
        }
        
        let vc = self.sliderPageViewController(for: index)
        self.viewControllersMap[index] = vc
        
        self.addChild(vc)
//        vc.beginAppearanceTransition(true, animated: false)
        vc.view.jcs_layout(superView: self.contentView) { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.view.frame.width)
            make.left.equalTo(self.view.frame.width * CGFloat(index))
        }
//        vc.didMove(toParent: self)
//        vc.endAppearanceTransition()
        
//        vc.view.alpha = 0
//        UIView.animate(withDuration: 0.25) {
//            vc.view.alpha = 1
//        }
        
        containerScrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.frame.width, y: 0), animated: false)
        
        isAddingPage = false
        return vc
    }
    
    func reloadData() {
        sliderTab?.reloadData()
    }
    
    func headerView() -> UIView? {
        return nil
    }
    
    // sliderTab顶部距离容器顶部的距离
    func sliderTabTop() -> CGFloat {
        return 0
    }
    // 获取页面数量
    func sliderPageCount() -> Int {
        return 0
    }
    // 获取页面标题
    func sliderPageTitle(for index: Int) -> String {
        return ""
    }
    // 获取Index对应的ViewController
    func sliderPageViewController(for index: Int) -> UIViewController {
        return UIViewController()
    }
}

extension SliderPageViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false{
            let pageIndex = scrollView.contentOffset.x / scrollView.frame.width
            addPage(for: Int(pageIndex))
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.width
        addPage(for: Int(pageIndex))
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.width
        addPage(for: Int(pageIndex))
    }
}
