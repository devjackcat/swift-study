//
//  EncryptUtil.h
//  swift-study
//
//  Created by 永平 on 2021/3/9.
//  Copyright © 2021 永平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptUtil : NSObject

#pragma mark - MD5
+ (NSString *)getMd5WithString:(NSString *)string;

#pragma mark - AES
+ (NSString *)encrypt_AES:(NSString *)str key:(NSString *)key;
+ (NSString *)decrypt_AES:(NSString *)str key:(NSString *)key;

#pragma mark - DES
+ (NSString *)encrypt_DES:(NSString *)str key:(NSString *)key;
+ (NSString *)decrypt_DES:(NSString *)str key:(NSString *)key;

#pragma mark - 3DES
+ (NSString *)encrypt_3DES:(NSString *)str key:(NSString *)key;
+ (NSString *)decrypt_3DES:(NSString *)str key:(NSString *)key;

@end


NS_ASSUME_NONNULL_END
