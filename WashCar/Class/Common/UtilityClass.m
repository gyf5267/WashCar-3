//
//  UtilityClass.m
//  CoreDataDemo
//
//  Created by nate on 15/7/9.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "UtilityClass.h"
#import <UIKit/UIKit.h>
#import "UIDevice+floatVersion.h"
#include <sys/xattr.h>  //不备份属性

@implementation UtilityClass

static UtilityClass* instace = nil;

+(id)shareInstance{
    @synchronized(self){
        if (instace==nil) {
            instace = [[UtilityClass alloc] init];
        }
    }
    return instace;
}

+(deviceType)deviceTypeIphone{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width == 320.f) {
        return deviceType4And5S;
    }else if(size.width == 375.f){
        return deviceType6;
    }else if(size.width == 414){
        return deviceType6Plus;
    }else{
        return deviceTypeNone;
    }
}

+(float)iphoneWidthOffset{
    deviceType type = [self deviceTypeIphone];
    switch (type) {
        case deviceType4And5S:
        case deviceTypeNone:
        {
            return 0;
        }
            break;
        case deviceType6:
        {
            return 27.5;
        }
            break;
        case deviceType6Plus:
        {
            return 47.0;
        }
            break;
            
        default:
            break;
    }
}

//添加“do not backup”的文件属性
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSString *)urlString
{
    if ([UIDevice deviceVersion] >= 5.1){
        NSError *error = nil;
        NSURL *URL = [NSURL fileURLWithPath:urlString];
        
        BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    } else {
        NSURL *URL = [NSURL URLWithString:urlString];
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
}


@end
