//
//  WashViewController.h
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCBaseViewController.h"
#import "WCBannerViewController.h"
#import "WCBaseTableViewController.h"

@interface WashViewController : WCBaseTableViewController

@property(nonatomic, retain)WCBannerViewController* bannerController;

@end
