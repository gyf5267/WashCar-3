//
//  MineViewController.h
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCBaseViewController.h"
#import "LoginView.h"

@interface MineViewController : WCBaseViewController
{
    UITableView* _mineTabView;
    NSMutableArray* _tabViewItemArray;
}

@property(nonatomic, retain)LoginView* infoView;

@end
