//
//  UIImageVIew+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        image = UIImage(named: imageName)
    }

    func jcs_image(image: UIImage) -> UIImageView {
        self.image = image
        return self
    }

    func jcs_image(imageName: String) -> UIImageView {
        image = UIImage(named: imageName)
        return self
    }

    func jcs_image(imageUrl: String, placeHolder: UIImage? = nil) -> UIImageView {
        return jcs_image(imageUrl: URL(string: imageUrl)!, placeHolder: placeHolder)
    }

    func jcs_image(imageUrl: URL, placeHolder: UIImage? = nil) -> UIImageView {
        kf.setImage(with: imageUrl, placeholder: placeHolder)
        return self
    }
}
