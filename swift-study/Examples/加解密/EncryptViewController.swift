//
//  EncryptViewController.swift
//  swift-study
//
//  Created by 永平 on 2021/3/9.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit
import CommonCrypto

class EncryptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.jcs_backgroundColor(.red)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let key = "12345678"
        
        var plainString = ""
        
        do {
            if let path = Bundle.main.path(forResource: "origin-json.json", ofType: nil) {
                plainString = try String(contentsOfFile: path, encoding: .utf8)
            }
            
            let v = Encrypt.desEncrypt(plainString, key: "12345678")
            let v2 = Encrypt.desDecrypt(v, key: key)
        } catch {
            
        }
    }
    
}
