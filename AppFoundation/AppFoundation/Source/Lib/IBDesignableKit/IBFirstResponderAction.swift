//
//  IBFirstResponderAction.swift
//  HJSwift
//
//  Created by PAN on 2017/11/10.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    @IBAction func IBPopViewController() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func IBDismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func IBPopViewControllerNoAnimated() {
        navigationController?.popViewController(animated: false)
    }

    @IBAction func IBDismissViewControllerNoAnimated() {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func IBEndEditing() {
        view.endEditing(true)
    }
}
