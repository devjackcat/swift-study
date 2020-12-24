//
//  JSON2Dict.swift
//  HJSwift
//
//  Created by PAN on 2017/12/18.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    func toJSONSerializationString() -> String? {
        guard let JSON = try? JSONSerialization.data(withJSONObject: self, options: []),
            let string = String(data: JSON, encoding: .utf8) else {
            return nil
        }
        return string
    }
}

public extension Array where Element: Equatable {
    func toJSONSerializationString() -> String? {
        guard let JSON = try? JSONSerialization.data(withJSONObject: self, options: []),
            let string = String(data: JSON, encoding: .utf8) else {
            return nil
        }
        return string
    }
}

public extension String {
    func toJSONDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8), let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            return json
        }
        return nil
    }

    func toJSONArray() -> [Any]? {
        if let data = self.data(using: .utf8), let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [Any] {
            return json
        }
        return nil
    }
}
