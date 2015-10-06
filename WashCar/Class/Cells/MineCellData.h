//
//  MineCellData.h
//  WashCar
//
//  Created by nate on 15/7/5.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    EnumMinecellWeizhang,
    EnumMinecellDingdan,
    EnumMinecellFankui,
    EnumMinecellMess
}EnumMinecellType;

@interface MineCellData : NSObject

@property(nonatomic, copy)NSString* cellName;
@property(nonatomic, assign)EnumMinecellType cellType;

@end
