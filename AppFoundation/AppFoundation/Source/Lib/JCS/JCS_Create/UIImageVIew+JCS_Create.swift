//
//  UIImageVIew+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import Kingfisher
import UIKit

public extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        image = UIImage(named: imageName)
    }

    @discardableResult
    func jcs_image(image: UIImage) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    func jcs_image(imageName: String) -> Self {
        image = UIImage(named: imageName)
        return self
    }

    @discardableResult
    func jcs_image(imageUrl: String, placeHolder: UIImage? = nil) -> Self {
        return jcs_image(imageUrl: URL(string: imageUrl)!, placeHolder: placeHolder)
    }

    @discardableResult
    func jcs_image(imageUrl: URL, placeHolder: UIImage? = nil) -> Self {
        kf.setImage(with: imageUrl, placeholder: placeHolder)
        return self
    }
}
