//
//  UIDevice+floatVersion.m
//  WashCar
//
//  Created by nate on 15/7/5.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "UIDevice+floatVersion.h"

@implementation UIDevice (floatVersion)

+(float)deviceVersion{
    float v = [[[UIDevice currentDevice] systemVersion] floatValue];
    return v;
}
@end
