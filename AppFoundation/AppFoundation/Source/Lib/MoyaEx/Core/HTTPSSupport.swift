//
//  HTTPSChallenge.swift
//  HJSwift
//
//  Created by PAN on 2018/8/20.
//  Copyright © 2018年 YR. All rights reserved.
//

import Alamofire
import Foundation

extension Alamofire.SessionManager {
    func bindHttpsSessionChallenge() {
        HTTPSSupport.shared.setupSessionChallenge(self)
    }
}

private class HTTPSSupport {
    static let shared: HTTPSSupport = {
        HTTPSSupport()
    }()

    private var httpsP12Data: Data?

    func setupSessionChallenge(_ manager: Alamofire.SessionManager) {
        manager.delegate.sessionDidReceiveChallenge = { _, challenge in
            // 认证服务器证书
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                #if DEVELOPSERVER
                    return (URLSession.AuthChallengeDisposition.useCredential,
                            URLCredential(trust: challenge.protectionSpace.serverTrust!))
                #else
                    let serverTrust = challenge.protectionSpace.serverTrust!
                    let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
                    let remoteCertificateData = CFBridgingRetain(SecCertificateCopyData(certificate))!

                    if remoteCertificateData.isEqual(self.localCertificateData) == true {
                        let credential = URLCredential(trust: serverTrust)
                        challenge.sender?.use(credential, for: challenge)
                        return (URLSession.AuthChallengeDisposition.useCredential,
                                URLCredential(trust: challenge.protectionSpace.serverTrust!))

                    } else {
                        return (.cancelAuthenticationChallenge, nil)
                    }
                #endif
            }
            // 认证客户端证书
            else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate {
                // 获取客户端证书相关信息
                if let identityAndTrust = self.extractIdentity {
                    let urlCredential = URLCredential(
                        identity: identityAndTrust.identityRef,
                        certificates: identityAndTrust.certArray as? [AnyObject],
                        persistence: URLCredential.Persistence.forSession
                    )

                    return (.useCredential, urlCredential)
                } else {
                    return (.cancelAuthenticationChallenge, nil)
                }
            }
            // 其它情况（不接受认证）
            else {
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }

    private var localCertificateData: Data? {
        return RouterConst.httpsCerData
    }

    private var _extractIdentity: IdentityAndTrust?

    // 获取客户端证b书相关信息
    private var extractIdentity: IdentityAndTrust? {
        if _extractIdentity != nil, httpsP12Data == RouterConst.httpsP12Data {
            return _extractIdentity
        }
        guard let PKCS12Data = RouterConst.httpsP12Data else {
            return nil
        }
        httpsP12Data = RouterConst.httpsP12Data

        var identityAndTrust: IdentityAndTrust?
        var securityError: OSStatus = errSecSuccess

        let key: NSString = kSecImportExportPassphrase as NSString
        let options: NSDictionary = [key: RouterConst.httpsP12Password ?? ""] // 客户端证书密码
        // create variable for holding security information

        var items: CFArray?
        securityError = SecPKCS12Import(PKCS12Data as CFData, options, &items)

        if securityError == errSecSuccess, let certItems = items {
            let certItemsArray: Array = certItems as Array
            let dict: AnyObject? = certItemsArray.first
            if let certEntry: Dictionary = dict as? [String: AnyObject] {
                // grab the identity
                let identityPointer: AnyObject? = certEntry["identity"]
                let secIdentityRef: SecIdentity = identityPointer as! SecIdentity
                // grab the trust
                let trustPointer: AnyObject? = certEntry["trust"]
                let trustRef: SecTrust = trustPointer as! SecTrust
                // grab the cert
                let chainPointer: AnyObject? = certEntry["chain"]
                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                    trust: trustRef, certArray: chainPointer!)
            }
        }
        _extractIdentity = identityAndTrust

        return identityAndTrust
    }

    // 定义一个结构体，存储认证相关信息
    private struct IdentityAndTrust {
        var identityRef: SecIdentity
        var trust: SecTrust
        var certArray: AnyObject
    }
}
