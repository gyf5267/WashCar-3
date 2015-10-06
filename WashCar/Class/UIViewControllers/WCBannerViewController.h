//
//  WCBannerViewController.h
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseViewController.h"
#import "WCPageView.h"

@interface WCBannerViewController : WCBaseViewController<UIScrollViewDelegate>
{
    
}

- (id)initWithFrame:(CGRect)frame;

@property(nonatomic, retain)UIScrollView* scrollView;
@property(nonatomic, retain)WCPageView *pageView;
//@property(nonatomic,retain) BTPageBannerData *currentData;
@property(nonatomic,retain) UIView *pageBgView;
@property(nonatomic,assign) CGRect viewFrame;
@property(nonatomic,retain) NSMutableArray *views;

@property(nonatomic,retain) NSArray *dataArray;


@end
