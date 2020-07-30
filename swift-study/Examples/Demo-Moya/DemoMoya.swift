//
//  DemoMoya.swift
//  swift-study
//
//  Created by 永平 on 2020/5/20.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

// https://api.jiakeniu.com/flyfish/params/aboutApp.action
// https://api.jiakeniu.com/flyfish/city/getSupportCityList.action
// https://api.jiakeniu.com/flyfish/goodstype/getList.action

// https://api.jiakeniu.com/flyfish/goods/getPageList.action
// {
//    "pageNo":1,
//    "pageSize":10
// }

//enum FlyfishApi {
//    case aboutApp
//    case supportCityList
//    case goodsTypeList
//    case goodsPageList(pageNo: Int, pageSize: Int)
//    case post
//}
//
//extension FlyfishApi: TargetType {
//
//     var path: String {
//        switch self {
//        case .aboutApp:
//            return "/params/aboutApp.action"
//        case .goodsTypeList:
//            return "/goodstype/getList.action"
//        case .supportCityList:
//            return "/city/getSupportCityList.action"
//        case .goodsPageList:
//            return "/goods/getPageList.action"
//        case .post:
//            return "/post"
//        }
//    }
//}
//
//class AboutApp: Codable {
//    var appIntroduction = ""
//    var appCustomerService = ""
//    var fullAppLogo = ""
//    var companyName = ""
//    var website = ""
//    var appName = ""
//}
//
//class DemoMoya {
//    func run() {
//        let provider = MoyaProvider<FlyfishApi>()
//        _ = provider.rx
////            .request(.goodsPageList(pageNo: 1, pageSize: 2))
//            .request(.aboutApp)
//            .asObservable()
////            .map { response -> Response in
////                guard let json = (try? response.mapJSON()) as? [String:AnyObject] else {
////                   return nil
////               }
////
////               guard let success = json["success"] as? Bool,success else {
////                   print("\(String(describing: json["msg"]))")
////                   return nil
////               }
////
////                guard let data = json["data"] as? [String:AnyObject] else {
////                   print("没数据")
////                   return nil
////               }
////                return data
////            }
//            .map(AboutApp.self, atKeyPath: "data")
//            .subscribe(onNext: { data in
//                print("\(data)")
//        })
//    }
//
//    func run2() {
//        let provider = MoyaProvider<FlyfishApi>()
//        _ = provider.rx.request(.goodsPageList(pageNo: 1, pageSize: 2)).subscribe(onSuccess: { response in
//
//            guard let json = (try? response.mapJSON()) as? [String: AnyObject] else {
//                return
//            }
//
//            guard let success = json["success"] as? Bool, success else {
//                print("\(String(describing: json["msg"]))")
//                return
//            }
//
//            guard let data = json["data"] else {
//                print("没数据")
//                return
//            }
//
//            print("\(data)")
//
//        }, onError: { error in
//            print("error = \(error)")
//        })
//    }
//}
