//
//  ViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import Closures
import RxCocoa
import RxRelay
import RxSwift
import SnapKit
import UIKit

class ViewController_bak: JCS_BaseVC {
    var label: UILabel!
    var explodeView: LSActivityExplodeView!
    var count = 0

    var clickBag = DisposeBag()

//    @IBOutlet var textShadowView: UIView! {
//        didSet {
//            textShadowView.backgroundColor = .white
//            textShadowView.layer.cornerRadius = 12
////            textShadowView.layer.masksToBounds = true
//            textShadowView.clipsToBounds = true
//            textShadowView.layer.shadowColor = UIColor(hex: 0x000000, alpha: 0.08).cgColor
//            textShadowView.layer.shadowOpacity = 0.8
//            textShadowView.layer.shadowRadius = 12
////            textShadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
////            textShadowView.layer.shadowOpacity = 0.8
////            textShadowView.layer.shadowRadius = 12
//        }
//    }

//    var single = Single<String>.create { _ in
//        //        single.success("aaa")
//        Disposables.create()
//    }

    override func awakeFromNib() {
        print("")
    }

    //    @IBAction func sendReqeust(_ sender: Any) {
    //        DemoMoya().run()
    //    }

    override func viewDidLoad() {
//        UIColor(hex: 0xA4AFD8)
//            >>> ItemView1.backgroundColor
//            >>> itemView2.backgroundColor
//            >>> itemView3.backgroundColor

//        view.backgroundColor = .systemPink
//        let layerView = UIView()
//            .jcs_layout(superView: view) { make in
//                make.center.equalTo(self.view)
        ////                make.leading.trailing.equalTo(self.view)
//                make.height.width.equalTo(200)
//            }
//            .jcs_backgroundColor_White()

//        // shadowCode
//        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        ////        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        layerView.layer.shadowOpacity = 0.8
//        layerView.layer.shadowRadius = 12
        // layerFillCode
//        let layer = CALayer()
//        layer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        layerView.layer.addSublayer(layer)
//        layerView.layer.cornerRadius = 12;

//        centerView.backgroundColor = UIColor.jcs_gradientColor(gradientStyle: .topToBottom,
//                                                               size: CGSize(width: UIScreen.main.bounds.size.width, height: 200),
//                                                               colors: [.clear, .white])

//        let clickButton = UIButton().jcs_title(title: "Click", state: .normal)
//            .jcs_titleColor(color: .black, state: .normal)
//            .jcs_layout(superView: self) { make in
//                make.center.equalTo(self.view)
//            }
//            .jcs_toButton()
//
//        let button = UIButton().jcs_title(title: "Remove Observer", state: .normal)
//            .jcs_titleColor(color: .black, state: .normal)
//            .jcs_layout(superView: self) { make in
//                make.centerX.equalTo(self.view)
//                make.top.equalTo(clickButton.snp.bottom).offset(50)
//            }
//            .jcs_toButton()

//        clickButton.rx.tap.subscribe(onNext: {
//            print("按钮被点击")
//            }).disposed(by: clickBag)
//
//        button.rx.tap.subscribe(onNext: { [weak self] _ in
//            guard let self = self else { return }
//            self.clickBag = DisposeBag()
//        }).disposed(by: bag)

//        callFunc = sayFunc
//        let content = callFunc?("张三")
//        print(content)

//        let subject1 = PublishSubject<String>()
//        let subject2 = PublishSubject<String>()
//        let subject3 = PublishSubject<String>()
//
//        subject1.subscribe(onNext: { print("---1---- \($0)") }).disposed(by: bag)

//        Observable.combineLatest(subject1,subject2).subscribe(onNext: {
//            print("s1 = \($0.0) s2 = \($0.1)")
//        }).disposed(by: bag)

//        subject1.concat(subject2).subscribe(onNext: {
//            print("---2---- \($0)")
//        }).disposed(by: bag)
//
//        subject2.concat(subject3).subscribe(onNext: {
//            print("---3---- \($0)")
//        }).disposed(by: bag)
//
//        subject1.onNext("1111")
//        subject2.onNext("AAAA")
//        subject3.onNext("TTTT")
//        subject1.onCompleted()
//        subject2.onNext("BBBB")
//        subject3.onNext("YYYY")
//
//        subject1.asDriver(onErrorJustReturn: "")
//
//        textField.rx.text.orEmpty
//            .map { $0.isEmpty }
//            .takeUntil(rx.deallocated)
//            .bind(to: titleLabel.rx.isHidden)
        ////            .disposed(by:bag)
//
//        let button = UIButton()
//        button.rx.tap

//        subject.subscribe(onNext: { print("---2---- \($0)") }).disposed(by: bag)
//        subject.onNext("Å")
//        subject.onNext("B")
//        subject.onNext("C")

//        subject.subscribe(onNext: { print("---1---- \($0)") }).disposed(by: bag)
//        subject.subscribe(onNext: { print("---2---- \($0)") }).disposed(by: bag)
//        subject.onNext("Å")
//        subject.onNext("B")
//        subject.onNext("C")
//        subject.onCompleted()

//        let subject2 = PublishSubject<String>.create(bufferSize: 2)
//        subject.subscribe(onNext: { print("---1---- \($0)") }).disposed(by: bag)
//        subject.subscribe(onNext: { print("---2---- \($0)") }).disposed(by: bag)
//        subject.onNext("Å")
//        subject.onNext("B")
//        subject.onNext("C")
//        subject.onNext("D")
//        subject.subscribe(onNext: { print("---3---- \($0)") }).disposed(by: bag)
//        subject.subscribe(onNext: { print("---4---- \($0)") }).disposed(by: bag)
//        subject.onCompleted()

//        Observable<String>.deferred { () -> Observable<String> in
//            return Observable<String>.create { (observer) -> Disposable in
//                observer.onNext("AAA")
//                observer.onNext("BBB")
//
//                return Disposables.create()
//            }
//        }.subscribe(onNext: { value in
//            print(value)
//        }).disposed(by: bag)

        print("")

//        super.viewDidLoad()
//        var array1 = [1,2,3,4] + [5,6,7]
//        print(array1)

//        let outObj = OutClass()
//        outObj.name = "outObjName"
//
//        let inner = OutClass.InnerClass()
//        inner.title = "innerTitle"
//        outObj.hello(inner: inner)
//        outObj.hello(inner: OutClass.InnerClass())
    }

    func sayFunc(content: String) -> String {
        return "say \(content)"
    }

    var callFunc: ((_ content: String) -> String)?

    override func jcs_setup() {
//        let say = sayFunc
//        say()

//        let tableView = UITableView(frame: .zero, style: .plain)
//            .jcs_layout(superView: self) { make in
//                make.edges.equalToSuperview()
//            }
//            .jcs_toTableView()
//
//        UILabel().jcs_layout(superView: self) { (make) in
//
//        }

//        tableView.addElements(["AA","BB","CC"], cell: AutoHeightDemoCell.self) { (data, cell, index) in
//            cell.titleLabel.text = data
//        }

//        let array = ["AA", "BB", "CC"]
//
//        tableView.register(AutoHeightDemoCell.self, forCellReuseIdentifier: "cell")
//        tableView.numberOfRows { _ in
//            array.count
//        }.cellForRow { (indexPath) -> UITableViewCell in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AutoHeightDemoCell
//            cell.titleLabel.text = array[indexPath.row]
//            return cell
//        }.didSelectRowAt { indexPath in
//            print(array[indexPath.item])
//        }

//        view.addTapGesture { (sender) in
//            print("addPanGesture")
//        }

//        let text = textField.rx.text.asDriver()
//            .compactMap { $0 }
//        //            .observeOn(MainScheduler.instance)
//        //            .catchErrorJustReturn("")
//
//        text
//            .map { $0.isEmpty ? "" : "hello \($0)" }
//        //            .bind(to: titleLabel.rx.text)
//            .drive(titleLabel.rx.text)
//            .disposed(by: bag)

        //        _ = Single<String>.create { observer -> Disposable in
        //            observer(.success("拉阿拉"))
        //            return Disposables.create()
        //        }
        //
        //        _ = Completable.create { observer -> Disposable in
        //            return Disposables.create()
        //        }
        //
        //        _ = Maybe.create(subscribe: { observer -> Disposable in
        //            return Disposables.create()
        //        })

        //          _ = UIControl()
        //                    .jcs_layout(superView: self) { (make) in
        //                        make.center.equalTo(self.view)
        //                        make.width.height.equalTo(200)
        //                    }
        //                    .jcs_backgroundColor_Random()
        //                    .jcs_cornerRadius(value: 100)
        //        //            .jcs_tap(closures: { (sender) in
        //        //                print("tap \(sender)")
        //        //            })
        //                    .jcs_toControl()
        //                    .jcs_click(closures: { (sender) in
        //                        print("click \(sender)")
        //                    })

        //        _ = UIImageView()
        //            .jcs_layout(superView: self) { (make) in
        //                make.center.equalTo(self.view)
        //                make.width.height.equalTo(200)
        //            }
        //            .jcs_backgroundColor_Random()
        //            .jcs_contentMode(mode: .scaleAspectFit)
        //            .jcs_toImageView().jcs_image(imageUrl: "http://static.devjackcat.com/Fnzn_0JGPGxwUtgvh3i4AsW9Dw8q")

        //        let xibView =  Bundle.main.loadNibNamed("BottomProcessView", owner: nil, options: nil)?.last as! UIView
        //        _ = xibView.jcs_layout(superView: self) { (make) in
        //            make.centerY.equalTo(self.view)
        //            make.width.equalTo(67)
        //            make.height.equalTo(87.5)
        //            make.leading.equalTo(20)
        //        }
        //
        //        _ = ProcessViewOne()
        //            .jcs_layout(superView: self) { (make) in
        //                make.center.equalTo(self.view)
        //                make.width.equalTo(67)
        //                make.height.equalTo(87.5)
        //        }
        //
        //        _ = ProcessViewTwo()
        //            .jcs_layout(superView: self) { (make) in
        //                make.centerY.equalTo(self.view)
        //                make.width.equalTo(67)
        //                make.height.equalTo(87.5)
        //                make.right.equalTo(-20)
        //        }

        //        explodeView = LSActivityExplodeView()
        //        _ = explodeView.jcs_layout(superView: self) { (make) in
        //            make.center.equalTo(self.view)
        //            make.width.equalTo(75)
        //            make.height.equalTo(52)
        //        }

        //        self.tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        //            .jcs_layout(superView: self, layout: { (make) in
        //                make.left.top.right.bottom.equalTo(0)
        //            })
        //        .jcs_toTableView()
        //
        //        self.tableView.register(AutoHeightDemoCell.self, forCellReuseIdentifier: "democell")
        //        self.tableView.dataSource = self
        //        self.tableView.delegate = self

//
//        event = button.rx.tap.asSignal()
//
//        button.rx.title(for: .normal).onNext("啦啦啦")
//
//        let observer: () -> Void = { print("---obser - 1") }
//        event.emit(onNext: observer)
//
//        self.view.jcs_backgroundColor_Random()
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        count += 1
//        explodeView.addItem(item: count)
//
//        let observer: () -> Void = { print("---obser - 2") }
//        event.emit(onNext: observer)

//        let vc = SecondVC()
//        self.present(vc, animated: true, completion: nil)

//        let vc = DemoReactorVC()
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.showDetailViewController(vc, sender: nil)

//        Observable<String>.create { observer -> Disposable in
//            observer.onNext("哈哈哈")
//            observer.onCompleted()
//            return Disposables.create()
//        }
//        .flatMap { value in
//            Observable<String>.create { observer -> Disposable in
//                observer.onNext("\(value) --- 1 -- ")
//                observer.onCompleted()
//                return Disposables.create()
//            }
//        }
//        .flatMap { value in
//            Observable<String>.create { observer -> Disposable in
//                observer.onNext("\(value) --- 2 -- ")
//                observer.onCompleted()
//                return Disposables.create()
//            }
//        }
//        .flatMap { value in
//            Observable<String>.create { observer -> Disposable in
//                observer.onNext("\(value) --- 3 -- ")
//                observer.onCompleted()
//                return Disposables.create()
//            }
//        }.subscribe(onNext: { value in
//            print("\(value)")
//            }).disposed(by: bag)
    }

    @IBAction func showIGDemo(_: Any) {
        let vc = IGDemoVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
//        if let vc = segue.destination as? SecondVC {
//            vc.title = "This is SecondVC"
//        }
    }

    @IBAction func testButtonClick(_: Any) {
        print("\(arc4random())")
    }
}
