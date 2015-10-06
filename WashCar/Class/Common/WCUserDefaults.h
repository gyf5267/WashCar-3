//
//  WCUserDefaults.h
//  WashCar
//
//  Created by nate on 15/7/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCUserDefaults : NSObject

+ (id)shareInstance;
+ (void)setValue:(id)value forKey:(NSString *)key;

//获得及设置QQ信息
+ (NSString *)openID;
+ (void)setOpenID:(NSString *)openID;

+ (NSString *)accessToken;
+ (void)setAccessToken:(NSString *)token;

+ (NSDate *)expirationDate;
+ (void)setExpirationDate:(NSDate *)date;

+ (NSString *)qqIconUrl;
+ (void)setQQIconUrl:(NSString *)url;

+(void)removeWithObjectKey:(NSString*)key;
+(void)removeQQ_Info;

//获取应用的版本号
+(NSString*)getVersionNum;
+(void)setVersionNum:(NSString*)version;

+(NSString*)createCachesDirectoryAndFile:(NSString*)path fileName:(NSString*)name;

+ (UIImage *)imageWithFillColor:(UIColor *)color size:(CGSize)size roundCorner:(CGFloat)radius;

//判断第一次启动的状态
+(BOOL)isFirstRun;
+(void)setFirstRun:(BOOL)first;





@end
