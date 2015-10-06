//
//  CpyDetailTableViewCell.h
//  WashCar
//
//  Created by nate on 15/8/28.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CpyDetailTableViewCell : UITableViewCell

@property(nonatomic, copy)NSString* imageName;
@property(nonatomic, copy)NSString* titleName;
@property(nonatomic, copy)NSString* titleDetail;

@property(nonatomic, assign)float discountPrice;
@property(nonatomic, assign)float originalPrice;

-(void)updateDetailCell;

@end
