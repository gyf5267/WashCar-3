//
//  WCUserDefaults.m
//  WashCar
//
//  Created by nate on 15/7/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCUserDefaults.h"
#import "PublicConstant.h"
#import "PublicDefine.h"
#import "UtilityClass.h"
@implementation WCUserDefaults

static WCUserDefaults* instance = nil;

+(id)shareInstance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[WCUserDefaults alloc] init];
        }
    }
    return instance;
}

+ (NSString *)openID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"openID"];
}

+ (void)setOpenID:(NSString *)openID{
    [self setValue:openID forKey:@"openID"];
}


+ (NSString *)accessToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
}

+ (void)setAccessToken:(NSString *)token{
    [self setValue:token forKey:@"accessToken"];
}

+ (NSDate *)expirationDate{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"expirationDate"];
}

+ (void)setExpirationDate:(NSDate *)date{
    [self setValue:date forKey:@"expirationDate"];
}


+ (NSString *)qqIconUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"icon_url"];
}

+ (void)setQQIconUrl:(NSString *)url{
    [self setValue:url forKey:@"icon_url"];
}


+ (void)setValue:(id)value forKey:(NSString *)key {
    if (nil == value) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];//立刻保存到UserDefaults（写文件）
}

+(void)removeQQ_Info{
    [self removeWithObjectKey:@"openID"];
    [self removeWithObjectKey:@"accessToken"];
    [self removeWithObjectKey:@"expirationDate"];
    [self removeWithObjectKey:@"icon_url"];
}

+(void)removeWithObjectKey:(NSString*)key{
    if (key != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:key];
        [defaults synchronize];//立刻保存到UserDefaults（写文件）
    }
}

//判断第一次启动的状态
+(BOOL)isFirstRun{
    return [[NSUserDefaults standardUserDefaults] objectForKey:First_Run];
}

+(void)setFirstRun:(BOOL)first{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:first forKey:First_Run];
    [defaults synchronize];//立刻保存到UserDefaults（写文件）
}

+(NSString*)getVersionNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Version_num];
}

+(void)setVersionNum:(NSString*)version{
    [self setValue:version forKey:Version_num];
}


+(NSString*)createCachesDirectoryAndFile:(NSString*)directory fileName:(NSString*)name{
    NSString * diskCachePath = [CACHE_PATH stringByAppendingPathComponent:directory];
    NSString* filePath = [diskCachePath stringByAppendingPathComponent:name];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[WCUserDefaults shareInstance] createFolder:diskCachePath];
        
        //文件夹加不备份的属性，很重要
        [UtilityClass addSkipBackupAttributeToItemAtURL:diskCachePath];
        
        [[WCUserDefaults shareInstance] createFile:filePath];
    }
    return filePath;
}

//创建文件夹
-(void)createFolder:(NSString*)path{
    if (path != nil) {
        NSFileManager* fm = [NSFileManager defaultManager];
        NSError* err = nil;
        
        if (![fm fileExistsAtPath:path]) {
            BOOL succ = [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
            if (succ) {
                NSLog(@"创建文件夹成功！！！");
            }else{
                NSLog(@"失败原因=%ld，创建文件夹失败！！！",(long)[err code]);
            }
        }
    }
}

//创建文件
-(void)createFile:(NSString*)path{
    if (path != nil) {
        NSFileManager* fm = [NSFileManager defaultManager];
        
        if (![fm fileExistsAtPath:path]) {
            BOOL succ = [fm createFileAtPath:path contents:nil attributes:nil];
            
            if (succ) {
                NSLog(@"创建文件成功！！！");
            }else{
                NSLog(@"创建文件失败！！！");
            }
            
        }
    }
}

//生成圆角图片
+ (UIImage *)imageWithFillColor:(UIColor *)color size:(CGSize)size roundCorner:(CGFloat)radius {
    
    // 计算坐标
    CGFloat scale = 2.0f;
    radius *= scale;
    size = CGSizeMake(size.width*scale, size.height*scale);
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    CGFloat minx = CGRectGetMinX(bounds);
    CGFloat miny = CGRectGetMinY(bounds);
    CGFloat maxx = CGRectGetMaxX(bounds);
    CGFloat maxy = CGRectGetMaxY(bounds);
    
    // 准备CGContext
    UIImage *img = nil;
    UIGraphicsBeginImageContext(bounds.size);// 可更改图片的大小
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 建立圆角剪裁区
    CGContextBeginPath(context);
    // Move to 1
    CGContextMoveToPoint(context, minx+radius, miny);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, minx, miny+radius, radius);
    CGContextAddLineToPoint(context, minx, maxy-radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, minx, maxy, minx+radius, maxy, radius);
    CGContextAddLineToPoint(context, maxx-radius, maxy);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, maxx, maxy-radius, radius);
    CGContextAddLineToPoint(context, maxx, miny+radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, maxx, miny, maxx-radius, miny, radius);
    // Close the path
    CGContextClosePath(context);
    
    // 填充剪裁区
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, color.CGColor);//view.backgroundColor.CGColor);
    CGContextFillRect(context, bounds);
    
    // 生成图片对象
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
