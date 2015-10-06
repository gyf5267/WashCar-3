//
//  ActivityDetailView.m
//  WashCar
//
//  Created by nate on 15/8/14.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "ActivityDetailView.h"
#import "WCBaseViewController+Navigation.h"
#import "HistroyViewController.h"

@implementation ActivityDetailView

-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
}

-(void)initNavigationBar{
    [self setNavBarTitle:@"活动"];
    
    [self setNavRigthButtonWithImageName:@"home_recently_play_btn.png" frame:CGRectMake(320-27-9, 9, 27, 29) target:self action:@selector(rightBtnClicked)];
}

-(void)rightBtnClicked{
    HistroyViewController* histroyCon = [[HistroyViewController alloc] init];
    
    [self.navigationController pushViewController:histroyCon animated:YES];
}

@end
