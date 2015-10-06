//
//  UtilityClass.h
//  CoreDataDemo
//
//  Created by nate on 15/7/9.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    deviceTypeNone,
    deviceType4And5S,
    deviceType6,
    deviceType6Plus,
    
}deviceType;

typedef NS_ENUM(NSInteger, _carType) {
    carType_car,
    carType_Small_SUV,
    carType_Large_medium_SUV,
};

typedef NS_ENUM(NSInteger, _beautyType) {
    beautyType_armor,
    beautyType_coating,
    beautyType_glazing,
};

@interface UtilityClass : NSObject

+(id)shareInstance;

+(deviceType)deviceTypeIphone;

+(float)iphoneWidthOffset;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSString *)urlString;
@end
