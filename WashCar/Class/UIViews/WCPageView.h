//
//  WCPageView.h
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCPageView : UIView

@property(nonatomic,assign) NSUInteger count;
@property(nonatomic,assign) NSUInteger index;
@property(nonatomic,assign) CGSize unitSize;
@property(nonatomic,retain) UIColor *normalColor;
@property(nonatomic,retain) UIColor *selectedColor;
@property(nonatomic,retain) NSMutableArray *views;

@end
