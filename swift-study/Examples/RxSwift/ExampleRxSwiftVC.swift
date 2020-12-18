//
//  ExampleRxSwiftVC.swift
//  swift-study
//
//  Created by 永平 on 2020/7/6.
//  Copyright © 2020 永平. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit
import AppFoundation

class UserApi {
    class func login() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            print("call api login start")
            print("call api login success")
            observer.onNext(true)
            return Disposables.create()
        }
    }

    class func getUserProfile() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            print("call api UserProfile start")
            print("call api UserProfile success")
            observer.onNext(true)
            return Disposables.create()
        }
    }

    class func getUserAssess() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            print("call api UserAssess start")
            print("call api UserAssess success")
            observer.onNext(true)
            return Disposables.create()
        }
    }

    class func getUserSetting() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            print("call api UserSetting start")
            print("call api UserSetting success")
            observer.onNext(true)
            return Disposables.create()
        }
    }
}

class ExampleRxSwiftVC: UIViewController {
    private var mergeSubject1 = PublishRelay<DemoItem>()
    private var mergeSubject2 = PublishRelay<DemoItem>()

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.of(mergeSubject1, mergeSubject2)
            .merge()
            .subscribe(onNext: { item in
                print("---merge.item = \(item.title)")
            })
            .disposing(with: self)
    }

    @IBAction func testLogin(_: Any) {
        UserApi.login() // 登陆接口
            .flatMap { _ in
                UserApi.getUserProfile() // 用户个人信息
            }
            .flatMap { _ in
                UserApi.getUserAssess() // 用户资产
            }
            .flatMap { _ in
                UserApi.getUserSetting() // 用户个性化
            }
            .subscribe(onNext: { _ in
                print("登陆成功")
              })
            .disposing(with: self)
    }

    @IBAction func mergeSubject1Click(_: Any) {
        let demoItem = DemoItem(title: "mergeSubject1Click")
        mergeSubject1.accept(demoItem)
    }

    @IBAction func mergeSubject2Click(_: Any) {
        let demoItem = DemoItem(title: "mergeSubject2Click")
        mergeSubject1.accept(demoItem)
    }
}

extension ExampleRxSwiftVC: StoryboardIdentifiable {
    static var storyboardName: String = "ExampleRxSwiftVC"
    static var storyboardIdentifier: String = "ExampleRxSwiftVC"
}
