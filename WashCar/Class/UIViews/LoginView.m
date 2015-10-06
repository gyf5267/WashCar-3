//
//  LoginView.m
//  WashCar
//
//  Created by nate on 15/7/4.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "LoginView.h"
#import "UIColorDef.h"

@interface LoginView ()
{
  
}

@end

@implementation LoginView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initContentViews];
    }
    return self;
}

-(void)initContentViews{
#if 0
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(128, 50, 51, 51);
    [loginBtn setImage:[UIImage imageNamed:@"addressbook_list_user.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
#else
    self.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(128, 50, 51, 51)];
    _imageView.userInteractionEnabled = YES;
//    s_imageView.image = [UIImage imageNamed:@"addressbook_list_user.png"];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClicked)];
    
    [_imageView addGestureRecognizer:singleTap];
    
    [self addSubview:_imageView];
    
#endif
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(60, 120, 200, 40)];
    label.text = @"登录后发现更多精彩";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    
}

-(void)btnClicked{
    if (_delegate && [_delegate respondsToSelector:@selector(loginBtnClicked)]) {
        [_delegate loginBtnClicked];
    }
}




@end
