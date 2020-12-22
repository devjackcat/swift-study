//
//  JCURLNavigator.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/22.
//

import Foundation
import URLNavigator

public protocol JCURLNavigatorProtocol {
    func register(navigator: Navigator)
    func handle(navigator: Navigator)
}

public class JCURLNavigator: NSObject {
    private static let navigator = Navigator()
    
    public static func loadRouters() {
//        var numClasses = 0
//        objc_getClassList(nil, 0)
//        let newNumClasses = objc_getClassList(nil, 0);
//        Class *classes = NULL;
//
//        while (numClasses < newNumClasses) { // 3
//            numClasses = newNumClasses;
//            classes = (Class *)realloc(classes, sizeof(Class) * numClasses);
//            newNumClasses = objc_getClassList(classes, numClasses);
//
//            for (int i = 0; i < numClasses; i++) {
//                Class class = classes[i];
//                if (class_conformsToProtocol(class, @protocol(JCURLNavigatorSubmodule))) {
//                    [(id<JCURLNavigatorSubmodule>)class register];
//                    [(id<JCURLNavigatorSubmodule>)class handle];
//                }
//            }
//        }
//        free(classes);
        
        var count: UInt32 = 0
        let allClasses = objc_copyClassList(&count)!
        
        for n in 0 ..< count {
            let someClass: AnyClass = allClasses[Int(n)]
            if let p = someClass.self as? JCURLNavigatorProtocol {
                print("conforms")
                p.handle(navigator: navigator)
                p.register(navigator: navigator)
            } else {
                print("does not conform")
            }
        }
    }
    
    static func handle(url: String, content: Any?) {
        if let url = URL(string: url) {
            navigator.push(url, context: content)
        }
    }
}

class XXRouter: JCURLNavigatorProtocol {
    func register(navigator: Navigator) {
        print("---------XXRouter.register(\(navigator)")
    }
    
    func handle(navigator: Navigator) {
        print("---------XXRouter.register(\(handle)")
    }
}
