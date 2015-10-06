//
//  WashTableViewCell.h
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WashCellData.h"

@interface WashTableViewCell : UITableViewCell

@property(nonatomic, retain)WashCellData* cellData;

-(void)updataCell;

@end
