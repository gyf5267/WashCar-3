//
//  QRCodeView.m
//  WashCar
//
//  Created by nate on 15/8/14.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "QRCodeView.h"
#import "QRCodeGenerator.h"
#import "PublicDefine.h"
#import "UIColorDef.h"

@implementation QRCodeView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIView* bg_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    bg_view.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.6];
    
    //增加点击手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [bg_view addGestureRecognizer:tap];
    //是否支持点击事件
    bg_view.userInteractionEnabled = YES;
    [self addSubview:bg_view];
    
    UIView* image_bg = [[UIView alloc] initWithFrame:CGRectMake(5, 60, ScreenWidth-10, ScreenWidth+20)];
    image_bg.backgroundColor = [UIColor whiteColor];
    [bg_view addSubview:image_bg];

    UILabel* lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
    lable.text = @"洗车服务码";
    [image_bg addSubview:lable];

    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, image_bg.frame.size.width, 0.5)];
    line.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    [image_bg addSubview:line];

    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth-10, ScreenWidth)];
    imageView.image = [self qrCodeWithData:@"123456"];
    [image_bg addSubview:imageView];
}

-(void)tapClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickedDisapper)]) {
            [_delegate clickedDisapper];
        }
    }
}

-(UIImage*)qrCodeWithData:(NSString*)data{
    return [QRCodeGenerator qrImageForString:data imageSize:self.frame.size.width];
}

@end
