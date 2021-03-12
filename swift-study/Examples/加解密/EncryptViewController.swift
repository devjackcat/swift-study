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
    
//

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        do {
            var plainString = ""
            if let path = Bundle.main.path(forResource: "origin-json.json", ofType: nil) {
                plainString = try String(contentsOfFile: path, encoding: .utf8)
            }

            var publicKey = ""
            if let path = Bundle.main.path(forResource: "rsa-public-key.txt", ofType: nil) {
                publicKey = try String(contentsOfFile: path, encoding: .utf8)
            }

            var privateKey = ""
            if let path = Bundle.main.path(forResource: "rsa-private-key.txt", ofType: nil) {
                privateKey = try String(contentsOfFile: path, encoding: .utf8)
            }

//            let v = RSAUtil.encryptString(plainString, publicKey: publicKey)
//            let v2 = RSAUtil.decryptString(v, privateKey: privateKey)
            
//            let v = RSAUtil.encryptString(<#T##str: String!##String!#>, publicKey: <#T##String!#>)
//            let v2 = RSAUtil.decryptString(v, privateKey: privateKey)

            print("")
        } catch {

        }
    }
    
    private func desDemo() {
        let key = "123456781234567812345678"
        
        var plainString = ""
        
        do {
            if let path = Bundle.main.path(forResource: "origin-json.json", ofType: nil) {
                plainString = try String(contentsOfFile: path, encoding: .utf8)
            }
            let v = EncryptUtil.encrypt_AES(plainString, key: key)
            let v2 = EncryptUtil.decrypt_AES(v, key: key)
            
            print("")
        } catch {
            
        }
    }
    
}
