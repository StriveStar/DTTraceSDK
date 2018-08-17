//
//  MD5Encryption.m
//  SensorsAnalyticsSDK
//
//  Created by 刘鑫鑫 on 2018/8/15.
//  Copyright © 2018年 SensorsData. All rights reserved.
//

#import "MD5Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Encryption
+ (NSString *)md5EncryptWithString:(NSString *)string{
    return [self md5: [NSString stringWithFormat:@"%@", string]];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

+ (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
