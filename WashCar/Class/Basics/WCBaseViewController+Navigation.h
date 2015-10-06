//
//  WCBaseViewController+Navigation.h
//  WashCar
//
//  Created by nate on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseViewController.h"

@interface WCBaseViewController (Navigation)

//添加自定义图形导航栏背景和标题
-(void)setNavBarTitle:(NSString*)title andBgView:(UIView*)bgView titleFrame:(CGRect)frame;

//添加自定义图形导航栏左侧按钮
- (void)setLeftButtonWithImageName:(NSString*)imageName
                             frame:(CGRect)frame
                            target:(id)target
                            action:(SEL)selector;

//添加自定义图形导航栏右侧按钮
- (void)setNavRigthButtonWithImageName:(NSString*)imageName
                                 frame:(CGRect)frame
                                target:(id)targart
                                action:(SEL)selector;
//普通标题及默认背景，带返回按钮
- (void)setNavBarTitle:(NSString *)title;

//导航栏背景
- (void)setNavBarBackgroundWithImage:(UIImage *)image;

@end
