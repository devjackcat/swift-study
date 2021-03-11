//
//  EncryptUtil.m
//  swift-study
//
//  Created by 永平 on 2021/3/9.
//  Copyright © 2021 永平. All rights reserved.
//

#import "EncryptUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation EncryptUtil

#pragma mark - MD5
+ (NSString*)getMd5WithString:(NSString *)string {
    const char* original_str=[string UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:16];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}

#pragma mark - AES
+ (NSString *)encrypt_AES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithmAES keySize:kCCKeySizeAES128 context:kCCEncrypt];
}
+ (NSString *)decrypt_AES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithmAES keySize:kCCKeySizeAES128 context:kCCDecrypt];
}

#pragma mark - DES
+ (NSString *)encrypt_DES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES context:kCCEncrypt];
}
+ (NSString *)decrypt_DES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES context:kCCDecrypt];
}

#pragma mark - 3DES
+ (NSString *)encrypt_3DES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithm3DES keySize:kCCKeySize3DES context:kCCEncrypt];
}
+ (NSString *)decrypt_3DES:(NSString *)str key:(NSString *)key {
    return [self doCipher:str key:key algorithm:kCCAlgorithm3DES keySize:kCCKeySize3DES context:kCCDecrypt];
}

#pragma mark - private method

/// 执行加密/解密
/// @param sTextIn 被处理的内容
/// @param sKey 秘钥
/// @param algorithm 算法(DES、3DES、AES.......)
/// @param keySize 秘钥长度
/// @param encryptOrDecrypt 加密、解密
+ (NSString *)doCipher:(NSString *)sTextIn
                   key:(NSString *)sKey
             algorithm:(CCAlgorithm)algorithm
             keySize:(uint32_t)keySize
               context:(CCOperation)encryptOrDecrypt {
    NSStringEncoding EnC = NSUTF8StringEncoding;
    
    NSMutableData * dTextIn;
    if (encryptOrDecrypt == kCCDecrypt) {
        dTextIn = [[[NSData alloc] initWithBase64EncodedString:sTextIn options:NSDataBase64DecodingIgnoreUnknownCharacters] mutableCopy];
    } else {
        dTextIn = [[sTextIn dataUsingEncoding: EnC] mutableCopy];
    }
    NSMutableData * dKey = [[sKey dataUsingEncoding:EnC] mutableCopy];
    [dKey setLength:keySize];
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
    //memset((void *) iv, 0x0, (size_t) sizeof(iv));
    bufferPtrSize1 = (([dTextIn length] + keySize) & ~(keySize -1));
    bufferPtr1 = malloc(bufferPtrSize1 * sizeof(uint8_t));
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);
    CCCrypt(encryptOrDecrypt, // CCOperation op
            algorithm, // CCAlgorithm alg
            kCCOptionPKCS7Padding, // CCOptions options
            [dKey bytes], // const void *key
            [dKey length], // size_t keyLength
            [dKey bytes], // const void *iv
            [dTextIn bytes], // const void *dataIn
            [dTextIn length],  // size_t dataInLength
            (void *)bufferPtr1, // void *dataOut
            bufferPtrSize1,     // size_t dataOutAvailable
            &movedBytes1);      // size_t *dataOutMoved
    NSString * sResult;
    if (encryptOrDecrypt == kCCDecrypt){
        sResult = [[NSString alloc] initWithData:[NSData dataWithBytes:bufferPtr1 length:movedBytes1] encoding:EnC];
    } else {
        NSData *dResult = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        sResult = [dResult base64EncodedStringWithOptions:0];
    }
    free(bufferPtr1);
    return sResult;
}

@end

