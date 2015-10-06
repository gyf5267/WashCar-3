//
//  Goods.h
//  WashCar
//
//  Created by nate on 15/8/29.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Goods : NSManagedObject

@property (nonatomic, retain) NSString * frugal;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * pay;
@property (nonatomic, retain) NSString * postLab;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * shopName;

@end
