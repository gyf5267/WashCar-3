//
//  CarTypeData.h
//  WashCar
//
//  Created by nate on 15/8/27.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CompanyInfo;

@interface CarTypeData : NSManagedObject

@property (nonatomic, retain) NSNumber * discountPrice;
@property (nonatomic, retain) NSNumber * originalPrice;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) CompanyInfo *info;

@end
