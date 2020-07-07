//
//  IBImageView.swift
//  HJSwift
//
//  Created by PAN on 2017/10/16.
//  Copyright © 2017年 YR. All rights reserved.
//

import UIKit

private let asyncQueue = DispatchQueue(label: "IBImageView", qos: DispatchQoS.userInteractive)

private class IBImageCache: NSCache<NSString, UIImage> {
    static let shared: IBImageCache = {
        let cache = IBImageCache()
        cache.countLimit = 20
        return cache
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(memoryWarning), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }

    @objc func memoryWarning() {
        removeAllObjects()
    }
}

private struct IBImageStyle: Hashable {
    var cornerRadius: CGFloat = 0
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    var contentMode: UIView.ContentMode = .scaleToFill
    var bounds: CGRect = .zero

    func hash(into hasher: inout Hasher) {
        hasher.combine(cornerRadius)
        hasher.combine(borderWidth)
        hasher.combine(borderColor)
        hasher.combine(contentMode)
        hasher.combine("\(bounds)")
    }

    func drawImage(_ rawImage: UIImage) -> UIImage? {
        guard bounds.width > 0, bounds.height > 0 else { return nil }

        func drawInContext(_ context: CGContext) {
            if borderWidth > 0 {
                context.setFillColor(borderColor.cgColor)
                let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
                path.fill()
            }

            let w = CGFloat.maximum(borderWidth, 0)
            context.addPath(UIBezierPath(roundedRect: bounds.insetBy(dx: w, dy: w), cornerRadius: cornerRadius).cgPath)
            context.clip()

            let frame = IBImageViewLayout.frameForImageWithSize(rawImage.size, inContainerWithSize: bounds.size, usingContentMode: contentMode)
            rawImage.draw(in: frame)
        }

        var resultImage: UIImage?
        if #available(iOS 10.0, *) {
            autoreleasepool {
                let render = UIGraphicsImageRenderer(bounds: bounds)
                let image = render.image { renderContext in
                    let context = renderContext.cgContext
                    drawInContext(context)
                }
                resultImage = image
            }
        } else {
            autoreleasepool {
                UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
                if let context = UIGraphicsGetCurrentContext() {
                    drawInContext(context)
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    resultImage = image
                }
                UIGraphicsEndImageContext()
            }
        }
        return resultImage
    }
}

@IBDesignable
class IBImageView: UIImageView {
    private var renderedSize: CGSize?
    private var shouldRender = false
    private var rawImage: UIImage?
    private var redrawedImage: UIImage?

    private static let group: DispatchGroup = {
        DispatchGroup()
    }()

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if cornerRadius != oldValue { setNeedsRender() }
            #endif
        }
    }

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if borderWidth != oldValue { setNeedsRender() }
            #endif
        }
    }

    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if borderColor != oldValue { setNeedsRender() }
            #endif
        }
    }

    override var image: UIImage? {
        set {
            guard newValue !== rawImage else {
                return
            }
            rawImage = newValue
            redrawedImage = nil

            if newValue == nil {
                super.image = nil
            } else {
                #if TARGET_INTERFACE_BUILDER
                    IDUpdateImage()
                #else
                    setNeedsRender()
                #endif
            }
        }
        get {
            return redrawedImage
        }
    }

    override var contentMode: UIView.ContentMode {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if contentMode != oldValue { setNeedsRender() }
            #endif
        }
    }

    private var imageStyle: IBImageStyle = IBImageStyle()

    private func getCacheKey() -> NSString? {
        if let rawImage = rawImage {
            let pointer = Unmanaged.passUnretained(rawImage as AnyObject).toOpaque()
            return "\(pointer)_\(imageStyle.hashValue)" as NSString
        }
        return nil
    }

    private func superSetImage(_ image: UIImage?) {
        super.image = image
    }

    deinit {
        if let cacheKey = getCacheKey() {
            IBImageCache.shared.removeObject(forKey: cacheKey)
        }
    }

    private func setNeedsRender() {
        // Xib里面设置了image，重新绘制
        if rawImage == nil, super.image != nil {
            superSetImage(nil)
            rawImage = super.image
        }
        if rawImage == nil {
            superSetImage(nil)
        } else if renderedSize != nil {
            shouldRender = true
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if shouldRender || renderedSize != frame.size {
            shouldRender = false
            renderedSize = frame.size
            IDUpdateImage()
        }
    }

    private func IDUpdateImage() {
        if rawImage == nil {
            superSetImage(nil)
            return
        }
        if cornerRadius <= 0, borderWidth <= 0 {
            superSetImage(rawImage)
            return
        }
        guard bounds.size.width > 0, bounds.size.height > 0 else {
            return
        }

        imageStyle.bounds = bounds
        imageStyle.contentMode = contentMode
        imageStyle.borderColor = borderColor
        imageStyle.borderWidth = max(0, borderWidth)
        imageStyle.cornerRadius = max(0, cornerRadius)

        #if TARGET_INTERFACE_BUILDER
            if let rawImage = rawImage {
                let image = imageStyle.drawImage(rawImage)
                redrawedImage = image
                superSetImage(image)
            }
        #else
            if let rawImage = rawImage {
                let cacheKey = getCacheKey()
                if let cacheKey = cacheKey, let cacheImage = IBImageCache.shared.object(forKey: cacheKey) {
                    superSetImage(cacheImage)
                } else {
                    asyncQueue.async(group: IBImageView.group) {
                        let image = self.imageStyle.drawImage(rawImage)
                        if let cacheKey = cacheKey, let image = image {
                            IBImageCache.shared.setObject(image, forKey: cacheKey)
                        }
                        DispatchQueue.main.async { [weak self] in
                            self?.redrawedImage = image
                            self?.superSetImage(image)
                        }
                    }
                }
            }
        #endif
    }
}

private struct IBImageViewLayout {
    static func frameForImageWithSize(_ image: CGSize, inContainerWithSize container: CGSize, usingContentMode contentMode: UIView.ContentMode) -> CGRect {
        let size = sizeForImage(image, container: container, contentMode: contentMode)
        let position = positionForImage(size, container: container, contentMode: contentMode)

        return CGRect(origin: position, size: size)
    }

    private static func sizeForImage(_ image: CGSize, container: CGSize, contentMode: UIView.ContentMode) -> CGSize {
        switch contentMode {
        case .scaleToFill:
            return container
        case .scaleAspectFit:
            let heightRatio = imageHeightRatio(image, container: container)
            let widthRatio = imageWidthRatio(image, container: container)
            return scaledImageSize(image, ratio: max(heightRatio, widthRatio))
        case .scaleAspectFill:
            let heightRatio = imageHeightRatio(image, container: container)
            let widthRatio = imageWidthRatio(image, container: container)
            return scaledImageSize(image, ratio: min(heightRatio, widthRatio))
        case .redraw:
            return container
        default:
            return image
        }
    }

    private static func positionForImage(_ image: CGSize, container: CGSize, contentMode: UIView.ContentMode) -> CGPoint {
        switch contentMode {
        case .scaleToFill:
            return .zero
        case .scaleAspectFit:
            return CGPoint(x: (container.width - image.width) / 2, y: (container.height - image.height) / 2)
        case .scaleAspectFill:
            return CGPoint(x: (container.width - image.width) / 2, y: (container.height - image.height) / 2)
        case .redraw:
            return .zero
        case .center:
            return CGPoint(x: (container.width - image.width) / 2, y: (container.height - image.height) / 2)
        case .top:
            return CGPoint(x: (container.width - image.width) / 2, y: 0)
        case .bottom:
            return CGPoint(x: (container.width - image.width) / 2, y: container.height - image.height)
        case .left:
            return CGPoint(x: 0, y: (container.height - image.height) / 2)
        case .right:
            return CGPoint(x: container.width - image.width, y: (container.height - image.height) / 2)
        case .topLeft:
            return .zero
        case .topRight:
            return CGPoint(x: container.width - image.width, y: 0)
        case .bottomLeft:
            return CGPoint(x: 0, y: container.height - image.height)
        case .bottomRight:
            return CGPoint(x: container.width - image.width, y: container.height - image.height)
        @unknown default:
            return CGPoint(x: 0, y: 0)
        }
    }

    private static func imageHeightRatio(_ image: CGSize, container: CGSize) -> CGFloat {
        return image.height / container.height
    }

    private static func imageWidthRatio(_ image: CGSize, container: CGSize) -> CGFloat {
        return image.width / container.width
    }

    private static func scaledImageSize(_ image: CGSize, ratio: CGFloat) -> CGSize {
        return CGSize(width: image.width / ratio, height: image.height / ratio)
    }
}
