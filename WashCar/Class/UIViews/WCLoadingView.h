//
//  WCLoadingView.h
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCLoadingView : UIView{
    UILabel *label ;
    UIView *aboveView;
    UIImageView *greenView;
}

- (void)startLoadingAnimation;

@end
