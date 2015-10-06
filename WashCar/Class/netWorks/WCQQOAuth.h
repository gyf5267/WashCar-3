//
//  WCQQOAuth.h
//  WashCar
//
//  Created by nate on 15/7/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>


@interface WCQQOAuth : NSObject

+(id)getShareInstance;

-(BOOL)reqQQUserInfo;
-(void)qq_Logout;

@property(nonatomic, retain)TencentOAuth* oAuth;

@end
