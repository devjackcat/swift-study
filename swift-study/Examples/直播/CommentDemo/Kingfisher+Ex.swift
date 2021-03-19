//
//  Kingfisher+Ex.swift
//  swift-study
//
//  Created by 永平 on 2021/3/19.
//  Copyright © 2021 永平. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

extension Reactive where Base: KingfisherManager {
    func retrieveImage(url: URL) -> Observable<UIImage>{
        return Observable.create { observor -> Disposable in
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case let .failure(error):
                    observor.onError(error)
                    break
                case let .success(image):
                    observor.onNext(image.image)
                    break
                }
            }
            return Disposables.create { }
        }
    }
    
    func retrieveImage(url: String) -> Observable<UIImage>{
        if let url = URL(string: url) {
            return retrieveImage(url: url)
        }
        return Observable.error(NSError(domain: " Kingfisher+Ex url 无效", code: 0, userInfo: nil))
    }
}

extension KingfisherManager: ReactiveCompatible {}
