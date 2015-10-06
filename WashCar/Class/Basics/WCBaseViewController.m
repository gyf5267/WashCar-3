//
//  WCBaseViewController.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseViewController.h"
#import "WCTabBarController.h"

@interface WCBaseViewController ()

@end

@implementation WCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.hideNavigationBarWhenPush = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tabBarIsNeeded];
}

-(void)tabBarIsNeeded{
    WCTabBarController* tabBarCon = (WCTabBarController*)self.tabBarController;
    
    if ([tabBarCon isKindOfClass:[WCTabBarController class]]) {
        [tabBarCon setTabBarState:self.hidesBottomBarWhenPushed];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNavigationItems];
}

-(void)removeNavigationItems{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
        _leftButton = nil;
    }
    
    if (_rightButton) {
        [_rightButton removeFromSuperview];
        _rightButton = nil;
    }
    
    if (_navBarTitle) {
        [_navBarTitle removeFromSuperview];
        _navBarTitle = nil;
    }
    
    if (_customBgView) {
        [_customBgView removeFromSuperview];
        _customBgView = nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
