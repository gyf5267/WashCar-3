//
//  WCBannerViewController.m
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBannerViewController.h"
#import "UIColorDef.h"
#import "WCUserDefaults.h"

@interface WCBannerViewController ()
{
    NSTimer* _timer;
}

@end
@implementation WCBannerViewController

#define KPScreen_W [UIScreen mainScreen].bounds.size.width //屏幕宽
#define KPScreen_H [UIScreen mainScreen].bounds.size.height //屏幕高

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        @autoreleasepool {
            _viewFrame = frame;
            [self initScrollView];
            [self initData];
        }
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    if (dataArray!=_dataArray) {
        _dataArray = dataArray;
        [self resetPages];
        [self resetPageView];
    }
}
- (void)startTimer {
    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

-(void)nextPage{
    if (_pageView.count>0) {
        _pageView.index = (_pageView.index+1)%_pageView.count;
        [_scrollView setContentOffset:CGPointMake(_pageView.index * _scrollView.bounds.size.width, 0) animated:YES];
    }
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

-(void)initScrollView{
    CGRect frame = _viewFrame;
    frame.origin = CGPointZero;
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = YES;
}

-(void)initData{
//    UIImage* image1 = [UIImage imageNamed:@"banner1.png"];
    UIImage* image2 = [UIImage imageNamed:@"banner2.png"];
    UIImage* image3 = [UIImage imageNamed:@"banner3.png"];
    
    self.dataArray = [NSArray arrayWithObjects: image2, image3, nil];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.frame = _viewFrame;
    
    UIImageView *defaultImageView = [[UIImageView alloc] initWithFrame:_viewFrame];
    defaultImageView.image = [UIImage imageNamed:@"banner_default.png"];
    [self.view addSubview:defaultImageView];
    
    [self.view addSubview:_scrollView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_pageView.count>1) {
        [self startTimer];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)resetPages {
    _views = [[NSMutableArray alloc] init];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _dataArray.count, _scrollView.bounds.size.height);
    _scrollView.contentOffset = CGPointZero;
    for (int i=0; i<self.dataArray.count; i++) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = i*frame.size.width;
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:frame];
//        view.autoDisplayActivityIndicator = YES;
        view.image = [self.dataArray objectAtIndex:i];
        view.tag = i;
       
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneBannerClicked:)];
        
        [view addGestureRecognizer:singleTap];
        
         view.userInteractionEnabled = YES;
        
        [_scrollView addSubview:view];
        [_views addObject:view];

    }
    
}

- (void)oneBannerClicked:(UITapGestureRecognizer* )touchView
{
    if ([touchView.view isKindOfClass:[UIImageView class]]) {
        UIImageView* image = (UIImageView*)touchView.view;
        NSUInteger dataIdx = image.tag;
        if (dataIdx<_dataArray.count) {
            NSLog(@"点击我啦！！！");
        }
    }

   
}

- (void)resetPageView {
    if (self.pageView!=nil) {
        [self.pageView removeFromSuperview];
        self.pageView = nil;
    }
    
    if (self.pageBgView != nil) {
        [self.pageBgView removeFromSuperview];
        self.pageBgView = nil;
    }
    
    if (self.dataArray.count>1) {
        self.pageView = [[WCPageView alloc] initWithFrame:CGRectZero];
        _pageView.unitSize = CGSizeMake(6, 6);
        _pageView.normalColor = [UIColor whiteColor];
        _pageView.selectedColor = UIColorWithRGB(51, 161, 246);
        
        CGFloat interval = 5;
        int pageCount = _scrollView.contentSize.width/_scrollView.bounds.size.width;
        CGFloat width = _pageView.unitSize.width * pageCount + interval * (pageCount-1);
        _pageView.frame = CGRectMake((KPScreen_W-width)/2, _scrollView.bounds.size.height-_pageView.unitSize.height-8, width, _pageView.unitSize.height);
        _pageView.count = pageCount;
        _pageView.index = 0;
        
        self.pageBgView = [[UIView alloc] initWithFrame:CGRectMake((KPScreen_W-width)/2-10, _scrollView.bounds.size.height-_pageView.unitSize.height-8-5, width+20, _pageView.unitSize.height+10)];
        _pageBgView.backgroundColor = [UIColor blackColor];
        _pageBgView.alpha = 0.1;
        
        _pageBgView.layer.cornerRadius = 8.0f;
        _pageBgView.clipsToBounds = YES;
        
        [self.view addSubview:_pageBgView];
        
        [self.view addSubview:_pageView];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollView==scrollView) {
        CGFloat pageWidth = _scrollView.bounds.size.width;
        _pageView.index = (int)(floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)%(_pageView.count?_pageView.count:1);
    }
}
@end
