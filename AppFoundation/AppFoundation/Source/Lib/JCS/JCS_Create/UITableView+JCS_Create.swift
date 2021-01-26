//
//  UITableView+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2020/5/22.
//

import UIKit

public extension UITableView {
    
    @discardableResult func jcs_registerCellClass(_ clazz: UITableViewCell.Type, identifier: String) -> Self {
        register(clazz, forCellReuseIdentifier: identifier)
        return self
    }
    @discardableResult func jcs_registerSectionHeaderFooterClass(_ clazz: UITableViewHeaderFooterView.Type, identifier: String) -> Self {
        register(clazz, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult func jcs_delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    @discardableResult func jcs_dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult func jcs_rowHeight(_ height: CGFloat) -> Self {
        self.rowHeight = height
        self.estimatedRowHeight = -1
        return self
    }
    @discardableResult func jcs_estimatedRowHeight(_ height: CGFloat) -> Self {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = height
        return self
    }
    @discardableResult func jcs_estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }
    @discardableResult func jcs_estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = height
        return self
    }
    @discardableResult func jcs_sectionHeaderHeight(_ height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }
    @discardableResult func jcs_sectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }
    
    @discardableResult func jcs_separatorColor(_ color: UIColor) -> Self {
        self.separatorColor = color
        return self
    }
    @discardableResult func jcs_separatorColor(_ hex: UInt, alpha: CGFloat = 1) -> Self {
        self.separatorColor = UIColor(hex: hex, alpha: alpha)
        return self
    }
    @discardableResult func jcs_separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = style
        return self
    }
    @discardableResult func jcs_separatorInset(_ insets: UIEdgeInsets) -> Self {
        self.separatorInset = insets
        return self
    }
    
    @discardableResult func jcs_allowsSelection(_ allows: Bool) -> Self {
        self.allowsSelection = allows
        return self
    }
    @discardableResult func jcs_allowsMultipleSelection(_ allows: Bool) -> Self {
        self.allowsMultipleSelection = allows
        return self
    }
    
    @discardableResult func jcs_tableHeaderView(_ view: UIView?) -> Self {
        tableHeaderView = view
        return self
    }
    @discardableResult func jcs_tableFooterView(_ view: UIView?) -> Self {
        tableFooterView = view
        return self
    }
    
    @discardableResult func jcs_editing(_ editing: Bool) -> Self {
        isEditing = editing
        return self
    }
    
}
