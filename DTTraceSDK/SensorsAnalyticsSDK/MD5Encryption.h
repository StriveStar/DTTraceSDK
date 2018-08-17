//
//  MD5Encryption.h
//  SensorsAnalyticsSDK
//
//  Created by 刘鑫鑫 on 2018/8/15.
//  Copyright © 2018年 SensorsData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encryption : NSObject

+ (NSString *)md5EncryptWithString:(NSString *)string;

+ (int)getRandomNumber:(int)from to:(int)to;

@end
