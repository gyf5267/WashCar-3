//
//  EngineInterface.h
//  WashCar
//
//  Created by nate on 15/8/14.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WashCarCompanyInfo.h"

@interface EngineInterface : NSObject

@property(nonatomic, strong)dispatch_queue_t currectQueue;

+(id)shareInstance;

-(NSString*)getVersionNum;
-(void)setVersionNum:(NSString*)version;

//cache文件夹
-(float)getCacheDirectorySize;
-(void)removeCacheDirectory;

-(NSArray*)fetchCpyInfo:(NSString*)cpyName;
-(NSArray*)fetchCpyInfo1:(NSString*)cpyName;

-(WashCarCompanyInfo*)fetchCpyInfoWithIndex:(NSString*)cpyName;

//根据公司名字删除公司的信息
-(BOOL)removeCpyInfoWithCpyName:(NSString*)cpyName;

//获得商品信息的接口
-(NSArray*)fetchGoodsInfo;


//测试接口
-(void)addTestData;


@end
