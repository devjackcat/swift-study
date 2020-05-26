//
//  Demo_RxSwift.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class XXItem:Equatable {
    static func == (lhs: XXItem, rhs: XXItem) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name = ""
    init(_ name:String) {
        self.name = name
    }
    func desc() {
        print(" XXItem \(self.name)")
    }
    
}

class Demo_Rxswift {
    
    let disposeBag = DisposeBag()
    
    func run() {
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                print("interval")
            })
    }
    
    func flatMapFirst() {

        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let John = Player(score: BehaviorRelay(value: 70))
        let Peter = Player(score: BehaviorRelay(value: 90))
        
        let players = PublishSubject<Player>()
        players
            .flatMapFirst { $0.score }
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)
        
        players.onNext(John)
        
        John.score.accept(10)
        
        players.onNext(Peter)
        John.score.accept(20)
        Peter.score.accept(40)
    }
    
    func flatMapLatest() {

        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let John = Player(score: BehaviorRelay(value: 70))
        let Peter = Player(score: BehaviorRelay(value: 90))
        
        let players = PublishSubject<Player>()
        players
            .flatMapLatest { $0.score }
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)
        
        players.onNext(John)
        
        John.score.accept(10)
        
        players.onNext(Peter)
        John.score.accept(20)
        Peter.score.accept(40)
    }
    
    func flatMap() {

        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let John = Player(score: BehaviorRelay(value: 70))
        let Peter = Player(score: BehaviorRelay(value: 90))
        
        let players = PublishSubject<Player>()
        players
            .flatMap { $0.score }
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)
        
        players.onNext(John)
        
        John.score.accept(10)
        
        players.onNext(Peter)
        John.score.accept(20)
        Peter.score.accept(40)
    }
    
    func distinctUntilChanged2() {
        let first = PublishSubject<XXItem>()
        first.distinctUntilChanged()
            .subscribe(onNext: {
                $0.desc()
            })
            .disposed(by: disposeBag)

        first.onNext(XXItem("A"))
        first.onNext(XXItem("B"))
        first.onNext(XXItem("B"))
        first.onNext(XXItem("B"))
        first.onNext(XXItem("C"))
        first.onNext(XXItem("C"))
        first.onNext(XXItem("C"))
    }
    
    func distinctUntilChanged1() {
        let first = PublishSubject<String>()
        first.distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        first.onNext("A")
        first.onNext("B")
        first.onNext("B")
        first.onNext("B")
        first.onNext("C")
        first.onNext("C")
    }
    
    func concatMap() {
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
//        first.concatMap(<#T##selector: (String) throws -> ObservableConvertibleType##(String) throws -> ObservableConvertibleType#>)
        
        first.concat(second)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
//        Observable.concat(first,second) { $0 + $1 }
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
        first.onNext("A")
        first.onNext("B")
        first.onNext("C")
        second.onNext("1")
        second.onNext("2")
        second.onNext("3")
        
//        first.onCompleted()
        second.onNext("ff")
    }
    
    func concat() {
                let first = PublishSubject<String>()
                let second = PublishSubject<String>()
                
                first.concat(second)
                    .subscribe(onNext: {
                        print($0)
                    })
                    .disposed(by: disposeBag)
                
        //        Observable.concat(first,second) { $0 + $1 }
        //            .subscribe(onNext: {
        //                print($0)
        //            })
        //            .disposed(by: disposeBag)
                
                first.onNext("aa")
                first.onNext("bb")
                second.onNext("cc")
                second.onNext("dd")
                first.onNext("ee")
                
                first.onCompleted()
                second.onNext("ff")
    }
    
    func zip() {
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()

        Observable.zip(first,second) { $0 + $1 }
          .subscribe(onNext: {
              print($0)
          })
          .disposed(by: disposeBag)

        first.onNext("aa")
        first.onNext("bb")
        second.onNext("cc")
        second.onNext("dd")
        first.onNext("ee")
    }
    
    func combineLatest() {
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        Observable.combineLatest(first,second) { $0 + $1 }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        first.onNext("aa")
        first.onNext("bb")
        second.onNext("cc")
        second.onNext("dd")
        first.onNext("ee")
        
        /**
         bbcc
         bbdd
         eedd
         */
    }
}
