//
//  WCNetWorkStatsManager.h
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCNetWorkStatsManager : NSObject

+(id)shareInstance;

//是否有网络
+(BOOL)isConnectionAvailable;

// 是否wifi
+ (BOOL) isEnableWIFI;

// 是否3G
+ (BOOL) isEnable3G;

@end
