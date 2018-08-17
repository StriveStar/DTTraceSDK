//
//  AppDelegate.m
//  HelloSensorsAnalytics
//
//  Created by 曹犟 on 15/7/4.
//  Copyright (c) 2015年 SensorsData. All rights reserved.
//

#import "AppDelegate.h"
#import "SensorsAnalyticsSDK.h"
#import "SAAppExtensionDataManager.h"
//数据接收的URL
#define SA_SERVER_URL @"http://127.0.0.1:9080/debug"
#define SA_LUA_URL @"http://172.16.10.89:7001"
//Debug 模式选项
// SensorsAnalyticsDebugOff -关闭 Debug模式
// SensorsAnalyticsDebugOnly -打开 Debug模式, 校验数据，但不进行数据导入
// SensorsAnalyticsDebugAndTrack -打开Debug模式，校验数据，并将数据导入Sensors Analytics中
#define SA_DEBUG_MODE SensorsAnalyticsDebugOnly
@interface AppDelegate ()

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:SA_SERVER_URL
                                        andDebugMode:SA_DEBUG_MODE];
    [[SensorsAnalyticsSDK sharedInstance] enableLog:YES];
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack];

    [[SensorsAnalyticsSDK sharedInstance] setMaxCacheSize:20000];
    [[SensorsAnalyticsSDK sharedInstance] enableHeatMap];
    [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:@{@"testValue" : @"testKey"}];
    //[[SensorsAnalyticsSDK sharedInstance] addHeatMapViewControllers:[NSArray arrayWithObject:@"DemoController"]];
    [[SensorsAnalyticsSDK sharedInstance] trackAppCrash];
    [[SensorsAnalyticsSDK sharedInstance] setFlushNetworkPolicy:SensorsAnalyticsNetworkTypeALL];
    [[SensorsAnalyticsSDK sharedInstance] addWebViewUserAgentSensorsDataFlag];
    [[SensorsAnalyticsSDK sharedInstance] enableTrackScreenOrientation:YES];
    [[SensorsAnalyticsSDK sharedInstance] enableTrackGPSLocation:YES];
    [[SensorsAnalyticsSDK sharedInstance] setFlushBeforeEnterBackground:YES];
    [[SensorsAnalyticsSDK sharedInstance] setFlushBulkSize:10];
//    [[[SensorsAnalyticsSDK sharedInstance] people] set:@"Sex" to:@"Male"];
//    [[[SensorsAnalyticsSDK sharedInstance] people] setOnce:@"AdSource" to:@"APP Store"];
//    [[[SensorsAnalyticsSDK sharedInstance] people] increment:@"GamePlayed" by:[NSNumber numberWithInt:1]];
//    [[[SensorsAnalyticsSDK sharedInstance] people] increment:@{
//                                                               @"UserPaid": [NSNumber numberWithInt:1],
//                                                               @"PointEarned": [NSNumber numberWithFloat:12.5]
//                                                               }];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[SensorsAnalyticsSDK sharedInstance] handleHeatMapUrl:url]) {
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){}];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //@"group.cn.com.sensorsAnalytics.share"
    [[SensorsAnalyticsSDK sharedInstance]trackEventFromExtensionWithGroupIdentifier:@"group.cn.com.sensorsAnalytics.share" completion:^(NSString *identifiy ,NSArray *events){
        
    }];
//   NSArray  *eventArray = [[SAAppExtensionDataManager sharedInstance] readAllEventsWithGroupIdentifier: @"group.cn.com.sensorsAnalytics.share"];
//    NSLog(@"applicationDidBecomeActive::::::%@",eventArray);
//    for (NSDictionary *dict in eventArray  ) {
//        [[SensorsAnalyticsSDK sharedInstance]track:dict[@"event"] withProperties:dict[@"properties"]];
//    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[SAAppExtensionDataManager sharedInstance]deleteEventsWithGroupIdentifier:@"dd"];
    //[[SAAppExtensionDataManager sharedInstance]readAllEventsWithGroupIdentifier:NULL];
    //[[SAAppExtensionDataManager sharedInstance]writeEvent:@"eee" properties:@"" groupIdentifier:@"ff"];
    //[[SAAppExtensionDataManager sharedInstance]fileDataCountForGroupIdentifier:@"ff"];
    //[[SAAppExtensionDataManager sharedInstance]fileDataArrayWithPath:@"fff" limit:-1];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"即将退出");
}



@end
