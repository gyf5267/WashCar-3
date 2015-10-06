//
//  MessageViewController.m
//  WashCar
//
//  Created by nate on 15/7/5.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "MessageViewController.h"
#import "WCBaseViewController+Navigation.h"

@implementation MessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarTitle:@"消息中心"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
