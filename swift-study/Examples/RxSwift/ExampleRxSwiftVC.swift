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

// PK类型
enum LinkPKScene {
    case undetected // 未知的
    case friends // 普通
    case linkScreen // 连屏
}

enum LSRoomScene: Equatable {
    
    enum Orientation: Int, Equatable {
        case portrait = 1
        case landscape = 2
    }
    /// 单播
    case normal(orientation: Orientation)
    /// 连麦PK
    case linkPk(scene: LinkPKScene)
    /// 3V3
    case group3v3
}



class ExampleRxSwiftVC: UIViewController {
    private var mergeSubject1 = PublishRelay<DemoItem>()
    private var mergeSubject2 = PublishRelay<DemoItem>()
    
    private var enumSubject = PublishRelay<LSRoomScene>()

    override func viewDidLoad() {
        super.viewDidLoad()

//        Observable.of(mergeSubject1, mergeSubject2)
//            .merge()
//            .subscribe(onNext: { item in
//                print("---merge.item = \(item.title)")
//            })
//            .disposing(with: self)
        
        enumSubject
            .distinctUntilChanged()
            .subscribe( onNext:{ scene in
                print("\(scene)")
            }).disposing(with: self)
        
        enumSubject.accept(.normal(orientation: .portrait))
        enumSubject.accept(.normal(orientation: .portrait))
        enumSubject.accept(.normal(orientation: .landscape))
        enumSubject.accept(.normal(orientation: .landscape))
        enumSubject.accept(.group3v3)
        enumSubject.accept(.linkPk(scene: .undetected))
        enumSubject.accept(.linkPk(scene: .undetected))
        enumSubject.accept(.linkPk(scene: .friends))
        enumSubject.accept(.linkPk(scene: .friends))
        enumSubject.accept(.linkPk(scene: .linkScreen))
        enumSubject.accept(.linkPk(scene: .linkScreen))

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
