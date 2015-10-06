//
//  WCNetWorkStatsManager.m
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCNetWorkStatsManager.h"
#import "Reachability.h"

@implementation WCNetWorkStatsManager

static WCNetWorkStatsManager* instance = nil;

+(id)shareInstance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[WCNetWorkStatsManager alloc] init];
        }
    }
    return instance;
}


+(BOOL)isConnectionAvailable{
    
    Reachability* reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    BOOL isAvailable = NO;
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
        {
           // 没有网络连接
        }
            
            break;
        // 使用WiFi网络
        case ReachableViaWiFi:
        case ReachableViaWWAN:
        {
            // 使用3G网络
            isAvailable = YES;
        }
            break;
        default:
            break;
    }
    
    return isAvailable;
}

// 是否wifi
+ (BOOL) isEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL) isEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
@end
