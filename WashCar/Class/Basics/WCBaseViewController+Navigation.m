 //
//  WCBaseViewController+Navigation.m
//  WashCar
//
//  Created by nate on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseViewController+Navigation.h"
#import "PublicDefine.h"

@implementation WCBaseViewController (Navigation)

-(void)setNavBarTitle:(NSString*)title andBgView:(UIView*)bgView titleFrame:(CGRect)frame{
    if (_customBgView == bgView) {
        return;
    }
    
    [self removeTitleAndBgView];
    
    _customBgView = bgView;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f) {
        _customBgView.frame = CGRectMake(0, -20, 320, 64);
    }else{
        _customBgView.frame = CGRectMake(0, -20, 320, 44);
    }
    
    [self.navigationController.navigationBar addSubview:_customBgView];
    
    _navBarTitle = [[UILabel alloc] init];
    _navBarTitle.backgroundColor = [UIColor clearColor];
    _navBarTitle.text = title;
    _navBarTitle.textColor = [UIColor whiteColor];
    _navBarTitle.font = [UIFont boldSystemFontOfSize:19.0f];
    _navBarTitle.frame = frame;
    _navBarTitle.textAlignment = NSTextAlignmentCenter;
    
    [_customBgView addSubview:_navBarTitle];
}

-(void)removeTitleAndBgView{
    if (_navBarTitle) {
        [_navBarTitle removeFromSuperview];
        _navBarTitle = nil;
    }
    
    if (_customBgView) {
        [_customBgView removeFromSuperview];
        _customBgView = nil;
    }
}


- (void)setLeftButtonWithImageName:(NSString*)imageName
                             frame:(CGRect)frame
                            target:(id)target
                            action:(SEL)selector
{
    [self removeNavigationLeftButton];
    _leftButton = [[UIButton alloc] initWithFrame:frame];
    [_leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_leftButton];
}

- (void)removeNavigationLeftButton{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
        _leftButton = nil;
    }
}

//添加自定义图形导航栏右侧按钮
- (void)setNavRigthButtonWithImageName:(NSString*)imageName
                                 frame:(CGRect)frame
                                target:(id)target
                                action:(SEL)selector
{
    [self removeNavigationRightButton];
    _rightButton = [[UIButton alloc] initWithFrame:frame];
    [_rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_rightButton];
}

- (void)removeNavigationRightButton{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
        _rightButton = nil;
    }
}

//普通标题及默认背景，带返回按钮
- (void)setNavBarTitle:(NSString *)title
{
    [self setNavBarTitle:title textColor:[UIColor blackColor] withDefaultBg:YES];
    
    if (_hasNavBackButton) {
        [self setLeftButtonWithImageName:@"nav_back_arrow_2.png" frame:CGRectMake(9, 9, 27, 29) target:self action:@selector(backButtonClicked:)];
    }
}

- (void)backButtonClicked:(id)pSender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavBarTitle:(NSString *)title textColor:(UIColor *)color withDefaultBg:(BOOL)hasDefaultBg
{
    if (hasDefaultBg) {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }else{
        [self setNavBarBackgroundWithImage:[UIImage imageNamed:@"nav_default_bg.png"]];
    }
    
    [self removeNavigationTitleAndBG];
    
    _navBarTitle = [[UILabel alloc] init];
    _navBarTitle.backgroundColor = [UIColor clearColor];
    _navBarTitle.textColor = color;
    _navBarTitle.text = title;
    _navBarTitle.frame = CGRectMake(36, 12, ScreenWidth - 72, 22);
    _navBarTitle.textAlignment = NSTextAlignmentCenter;
    _navBarTitle.font = [UIFont boldSystemFontOfSize:19];
    
    [self.navigationController.navigationBar addSubview:_navBarTitle];
}


//导航栏背景
- (void)setNavBarBackgroundWithImage:(UIImage *)image{
    [self removeNavigationTitleAndBG];
    
    if (_customBgView == nil) {
        _customBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 64)];
        _customBgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    }
    if ([_customBgView isKindOfClass:[UIImageView class]]) {
        UIImageView* imageView = (id)_customBgView;
        imageView.image = image;
    }
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f) {
        _customBgView.frame = CGRectMake(0, -20, self.view.bounds.size.width, 64);
    }else{
        _customBgView.frame = CGRectMake(0, -20, 320, 44);
    }
    
    [self.navigationController.navigationBar addSubview:_customBgView];
    
    if (_navBarTitle) {
        [self.navigationController.navigationBar insertSubview:_customBgView aboveSubview:_navBarTitle];
    }
}

-(void)removeNavigationTitleAndBG{
    if (_navBarTitle) {
        [_navBarTitle removeFromSuperview];
        _navBarTitle = nil;
    }
    if (_customBgView) {
        [_customBgView removeFromSuperview];
        _customBgView = nil;
    }
}

@end
