//
//  ZiDingYiTableViewCell.h
//  Wash_Car_Club
//
//  Created by 中软国际013 on 15/8/11.
//  Copyright (c) 2015年 中软国际027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WashCarCompanyInfo.h"

@interface ZiDingYiTableViewCell : UITableViewCell

@property(nonatomic, retain)WashCarCompanyInfo* cellData;

-(void)updataCell;

@end
