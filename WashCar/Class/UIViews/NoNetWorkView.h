//
//  NoNetWorkView.h
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoNetWorkView : UIView{
    UIImageView *imageView;
    UITextView *label;
    UIView *aboveView;
}

- (id)initWithError:(NSError *)error target:(id)target action:(SEL)action;

@end
