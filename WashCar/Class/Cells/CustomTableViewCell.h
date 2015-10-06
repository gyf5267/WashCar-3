//
//  CustomTableViewCell.h
//  WashCar
//
//  Created by nate on 15/9/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMyData.h"

@interface CustomTableViewCell : UITableViewCell

@property(nonatomic, strong) CustomMyData* myData;

-(void)updateMyCell;

@end
