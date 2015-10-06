//
//  ShareView.m
//  Setting
//
//  Created by 中软国际035 on 15/8/18.
//  Copyright (c) 2015年 中软国际035. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)bgViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        UIView* imageVied = (UIView*)tap.view;
        if (imageVied.tag == 100) {
            [_delegate shareViewDisappear];
        }
    }
}
-(void)initUI{
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    bgView.tag = 100;
    bgView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.6];
    bgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClicked:)];
    [bgView addGestureRecognizer:tap1];
    
    [self addSubview:bgView];
    
    UIView* share_bg = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200)];
    share_bg.backgroundColor  = [UIColor whiteColor];
    [bgView addSubview:share_bg];
    share_bg.userInteractionEnabled = YES;
    
    int pos = 28;
    int aa = 45;
    for (int index=0; index<8; index++) {
        CGRect frame;
        if (index<=3) {
           frame = CGRectMake(pos*index+aa*index+pos, 40, aa, aa);
        }else{
            int bb = index-4;
            frame = CGRectMake(pos*bb+aa*bb+pos, 110, aa, aa);
        }
        
        NSString* imageName = [NSString stringWithFormat:@"share_platform_%d.png",index+1];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = frame;
        
        imageView.userInteractionEnabled =YES;
        imageView.tag = index;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
        [imageView addGestureRecognizer:tap];
        
        [share_bg addSubview:imageView];
        
    }
}

-(void)imageViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        if (tap) {
            UIImageView* imageVied = (UIImageView*)tap.view;
            if (_delegate && [_delegate respondsToSelector:@selector(shareTypeWithIndex:)]) {
                [_delegate shareTypeWithIndex:imageVied.tag];
            }
        }

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
