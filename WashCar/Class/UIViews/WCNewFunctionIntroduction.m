//
//  WCNewFunctionIntroduction.m
//  WashCar
//
//  Created by nate on 15/8/17.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCNewFunctionIntroduction.h"
#import "PublicDefine.h"

#define New_Function_Page_Count (5)

@interface WCNewFunctionIntroduction ()<UIScrollViewDelegate>
{
    UIScrollView* _scrollView;
    NSMutableArray* imageArray;
    UIPageControl* pageControl;
}

@end

@implementation WCNewFunctionIntroduction

+(void)showView{
    [UIApplication sharedApplication].statusBarHidden = YES;
    WCNewFunctionIntroduction* newView = [[WCNewFunctionIntroduction alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [[UIApplication sharedApplication].keyWindow addSubview:newView];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initScrollView];
        [self scrollViewWithImage];
        [self initPageControll];
    }
    return self;
}

-(void)initScrollView{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    
    [self addSubview:_scrollView];
}

-(void)scrollViewWithImage{
    _scrollView.contentSize = CGSizeMake(New_Function_Page_Count*ScreenWidth, ScreenHeight);
    
    for (int index=0; index<New_Function_Page_Count; index++) {
        NSString* imageName = [NSString stringWithFormat:@"welcome47_%d.jpg", index+1];
        UIImageView* imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(index*ScreenWidth, 0, ScreenWidth, ScreenHeight);
        imageView.tag = index;
        
        [_scrollView addSubview:imageView];
        
        if (index == 4) {
            imageView.userInteractionEnabled = YES;
            UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, ScreenHeight - 70, 100, 60)];
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:btn];
        }
    }
}

-(void)btnClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
#if 0
        [self removeFromSuperview];
#else
        [UIView animateWithDuration:2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0.0;
        }completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
#endif
    }
}

-(void)initPageControll{
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth/2-60/2, ScreenHeight-35, 60, 30)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = New_Function_Page_Count;
    pageControl.currentPage = 0;
    
    [_scrollView addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSLog(@"pageWidth=%f",pageWidth);
    int page = (int)(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1);
    
    NSLog(@"page=%d",page);
    pageControl.frame = CGRectMake(ScreenWidth*page+(ScreenWidth/2-60/2), ScreenHeight-35, 60, 30);
    pageControl.currentPage = page;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
