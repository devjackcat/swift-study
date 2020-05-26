//
//  UIControl+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIControl {
    func jcs_click(closures: @escaping (_ sender: UIControl) -> Void) -> UIControl {
        _ = self.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] _ in
            closures(self!)
        })
        return self
    }
}
