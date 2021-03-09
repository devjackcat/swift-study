//
//  Test.h
//  swift-study
//
//  Created by 永平 on 2021/3/9.
//  Copyright © 2021 永平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject



@end

@interface Encrypt : NSObject

+ (NSString *)getMd5WithString:(NSString *)string;
+ (NSString *)DESEncrypt:(NSString *)str key:(NSString *)key;
+ (NSString *)DESDecrypt:(NSString *)str key:(NSString *)key;

@end


NS_ASSUME_NONNULL_END
