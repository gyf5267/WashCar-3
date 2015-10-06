//
//  MineTableViewCell.h
//  WashCar
//
//  Created by nate on 15/7/5.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCellData.h"

@interface MineTableViewCell : UITableViewCell

@property(nonatomic, retain)MineCellData* cellData;

-(void)updateCell;

@end
