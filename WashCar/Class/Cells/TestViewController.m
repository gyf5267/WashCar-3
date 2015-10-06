//
//  TestViewController.m
//  WashCar
//
//  Created by nate on 15/9/3.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "TestViewController.h"
#import "WCBaseViewController+Navigation.h"

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNagationBar];
}

-(void)initNagationBar{
    [self setNavBarTitle:@"设置"];
}
@end
