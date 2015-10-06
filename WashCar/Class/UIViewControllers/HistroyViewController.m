//
//  HistroyViewController.m
//  WashCar
//
//  Created by nate on 15/7/2.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "HistroyViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "UIColorDef.h"

@interface HistroyViewController ()

@end

@implementation HistroyViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)initNavBar{    
    [self setNavBarTitle:@"定时"];

}
@end
