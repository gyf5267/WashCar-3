//
//  WashCellData.h
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WashCellData : NSObject

@property(nonatomic, retain)UIImage* leftImage;
@property(nonatomic, copy)NSString* labelText;
@property(nonatomic, copy)NSString* detailLabelText;
@property(nonatomic, assign)float   distance;
@property(nonatomic, assign)NSInteger starCount;

@end
