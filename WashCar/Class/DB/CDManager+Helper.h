//
//  CDManager+Helper.h
//  CoreDataDemo
//
//  Created by nate on 15/7/10.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "CDManager.h"

@interface CDManager (Helper)

//向数据库写入数据
-(BOOL)addObjectData:(id)data;

//返回数据库的所有数据
-(NSArray*)findAllObjectData:(NSError**)error;

//返回指定公司数据
-(NSArray*)findObjectWithCpyName:(NSString*)cpyName errCode:(NSError**)error;

//修改指定数据库数据
-(BOOL)modifyObjectData:(id)object;

//删除数据库所有数据
-(BOOL)removeAllObject;

//删除公司信息
-(BOOL)removeCpyInfo:(NSString*)cpyName;

//返回店铺信息
-(NSArray*)fetchGoodsFromDB;

@end
