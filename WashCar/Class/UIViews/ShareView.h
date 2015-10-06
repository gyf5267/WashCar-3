//
//  ShareView.h
//  Setting
//
//  Created by 中软国际035 on 15/8/18.
//  Copyright (c) 2015年 中软国际035. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate <NSObject>

-(void)shareTypeWithIndex:(NSInteger)index;
-(void)shareViewDisappear;

@end

@interface ShareView : UIView

-(id)initWithFrame:(CGRect)frame;

@property(nonatomic, weak)id<ShareViewDelegate> delegate;

@end
