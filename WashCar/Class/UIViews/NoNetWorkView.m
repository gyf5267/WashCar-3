//
//  NoNetWorkView.m
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "NoNetWorkView.h"
#import "PublicDefine.h"

@implementation NoNetWorkView

- (id)initWithError:(NSError *)error target:(id)target action:(SEL)action{
    self = [super init];
    if(self){
        self.frame= [UIScreen mainScreen].bounds;
        aboveView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, ScreenWidth, 200)] ;
        [self addSubview:aboveView];
        
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-149)/2, 50, 149, 97)];
        imageView.image = [UIImage imageNamed:@"default_normal.png"];
        [aboveView addSubview:imageView];
        
        label = [[UITextView alloc] initWithFrame:CGRectMake(3, 152, ScreenWidth, 100)] ;
        //label.verticalAlignment = VerticalAlignmentTop;
        label.editable = NO;
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = nil;
        label.font = [UIFont systemFontOfSize:19];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:99.9/255. green:98.0/255. blue:96.0/255. alpha:1.];
        [aboveView addSubview:label];
        
    
        label.text = alertNoNetListenLocalStories;
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:tap];
    }
    return self;
}



- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    float height = frame.size.height;
    CGRect rect = aboveView.frame;
    rect.origin.y = (height-200)/2;
    aboveView.frame = rect;
}

@end
