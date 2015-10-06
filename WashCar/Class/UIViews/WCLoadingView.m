//
//  WCLoadingView.m
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCLoadingView.h"
#import "PublicDefine.h"

@implementation WCLoadingView

- (id)init{
    self = [super init];
    if(self){
        self.frame= [UIScreen mainScreen].bounds;
        
        
        aboveView = [[UIView alloc] initWithFrame:CGRectMake(0, (ScreenHeight-200)/2, ScreenWidth, 200)];
        [self addSubview:aboveView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-149)/2, 50, 149, 97)];
        imageView.image = [UIImage imageNamed:@"default_loading.png"];
        [aboveView addSubview:imageView];
        
    
        greenView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 6, 90, 90)];
        greenView.image = [UIImage imageNamed:@"loadingGreen.png"];
        [imageView addSubview:greenView];
        
        [self startLoadingAnimation];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(3, 102+50, ScreenWidth, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"正在加载中...";
        label.font = [UIFont systemFontOfSize:19];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:99.9/255. green:98.0/255. blue:96.0/255. alpha:1.];
        [aboveView addSubview:label];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWhenAppWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)startLoadingAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.repeatCount = HUGE_VALF;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    animation.duration = 1.0f;
    [greenView.layer addAnimation:animation forKey:@"loadingAnimation"];
}

- (void)updateWhenAppWillEnterForeground {
    [self startLoadingAnimation];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    float height = frame.size.height;
    CGRect rect = aboveView.frame;
    rect.origin.y = (height-200)/2;
    aboveView.frame = rect;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
