//
//  LoginView.h
//  WashCar
//
//  Created by nate on 15/7/4.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

@required

-(void)loginBtnClicked;


@end

@interface LoginView : UIView

@property(nonatomic,retain)UIImageView* imageView;

@property (nonatomic,assign) id<LoginViewDelegate> delegate;


@end
