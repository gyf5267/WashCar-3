//
//  QRCodeView.h
//  WashCar
//
//  Created by nate on 15/8/14.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRCodeViewDelegate <NSObject>

-(void)clickedDisapper;

@end

@interface QRCodeView : UIView

@property(nonatomic, weak)id<QRCodeViewDelegate> delegate;

//构建二维码的信息
@property(nonatomic, copy)NSString* data;

-(id)initWithFrame:(CGRect)frame;

@end
