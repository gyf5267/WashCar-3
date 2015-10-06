//
//  SettingViewController.m
//  WashCar
//
//  Created by nate on 15/7/4.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "SettingViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "WCQQOAuth.h"
#import "WCUserDefaults.h"
#import "EngineInterface.h"
#import "CustomViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarTitle:@"设置"];
    [self initUI];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initUI{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(60, 400, 200, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle: @"退出QQ登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:btn];
    
    UIButton* testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(60, 460, 200, 40);
    testBtn.backgroundColor = [UIColor redColor];
    [testBtn setTitle: @"测试功能专用" forState:UIControlStateNormal];
    testBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    testBtn.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:testBtn];
    
    
}

//测试引擎类(EngineInterface)的接口
-(void)testBtnClicked{
#if 0
    BOOL succ = [[EngineInterface shareInstance] removeCpyInfoWithCpyName:@"米其林驰加胜利路店"];
    
    if (succ) {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"测试成功" message:@"您测试的接口正常返回啦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alerView show];
    }
#else
    CustomViewController* customController = [[CustomViewController alloc] init];
    
    [self.navigationController  pushViewController:customController animated:YES];
#endif
}

-(void)btnClicked:(id)sender{
    [[WCQQOAuth getShareInstance] qq_Logout];
    [WCUserDefaults removeQQ_Info];
}

@end
