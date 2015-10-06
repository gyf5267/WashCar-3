//
//  WCBaseViewController.h
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCBaseViewController : UIViewController
{
    UIButton* _leftButton;           //导航栏左侧按钮
    UIButton* _rightButton;          //导航栏右侧按钮
    UILabel* _navBarTitle;           //导航栏标题
    UIView   *_customBgView;         //自定义背景view
    
    BOOL    _hasNavBackButton;       //是否需要返回键
}

@property(nonatomic, assign)BOOL hasNavBackButton;

@property(nonatomic,assign) BOOL hideNavigationBarWhenPush;


@end
