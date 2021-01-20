//
//  JCSRuntime.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/20.
//

import UIKit

public class JCSRuntime: NSObject {
    private static let instance = JCSRuntime()
    private var maps = [String: String]()
    
    private static var defaultBundleName: String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")! as! String
        return name.replacingOccurrences(of: "-", with: "_")
    }
    
    // 加载需要runtime创建的class
    public static func loadRuntimeClasses() {
        guard let path = Bundle.main.path(forResource: "jcs_runtime_classes.plist", ofType: nil) else { return }
        guard let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else { return }
        dict.forEach { (key: String, value: AnyObject) in
            if let items = value as? [String] {
                items.forEach { clazz in
                    JCSRuntime.instance.maps[clazz] = "\(key).\(clazz)"
                }
            }
        }
    }
    
    // 创建实例
    public static func createInstance(for clazz: String) -> AnyObject? {
        guard let fullClassName = JCSRuntime.instance.maps[clazz] else {
            // 不存在，则默认尝试主工程获取
            return createInstance(fullClassName: "\(defaultBundleName).\(clazz)")
        }
        return createInstance(fullClassName: fullClassName)
    }
    
    private static func createInstance(fullClassName: String) -> AnyObject? {
        guard let cls = NSClassFromString(fullClassName) as? NSObject.Type else {
            return nil
        }
        return cls.init()
    }
}
