//
//  WCQQOAuth.m
//  WashCar
//
//  Created by nate on 15/7/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCQQOAuth.h"
#import "WCUserDefaults.h"
#import "WCNotification.h"

@interface WCQQOAuth ()<TencentSessionDelegate>
{
    
}

@end

@implementation WCQQOAuth

static WCQQOAuth* instance = nil;
#define __TencentDemoAppid_  @"222222"

+(id)getShareInstance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[WCQQOAuth alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        NSString *appid = __TencentDemoAppid_;
        _oAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
    }
    return self;
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    NSLog(@"登录成功");
    [WCUserDefaults setOpenID:self.oAuth.openId];
    [WCUserDefaults setAccessToken:self.oAuth.accessToken];
    [WCUserDefaults setExpirationDate:self.oAuth.expirationDate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:QQ_Login_Successed object:nil];
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSLog(@"登录失败");
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"网络有问题");
}

-(BOOL)reqQQUserInfo{
    if (self.oAuth.getUserInfo == NO) {
        return NO;
    }
    return YES;
}

-(void)qq_Logout{
    [self.oAuth logout:self];
    
}

- (void)getUserInfoResponse:(APIResponse*) response{
    if (response.retCode == 0) {
        
        if ([NSJSONSerialization isValidJSONObject:response.jsonResponse]) {
            NSString* iconUrl = [response.jsonResponse objectForKey:@"figureurl_qq_1"];
            [WCUserDefaults setQQIconUrl:iconUrl];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:QQ_GetInfo_Notification object:nil];
        }
    }else{
        NSLog(@"错误信息返回");
    }
}
@end
