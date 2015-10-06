//
//  WCTabBarController.h
//  WashCar
//
//  Creat/Volumes/MacWork/WC/WashCar/WashCared by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCTabBarController : UITabBarController
{
   NSMutableArray* _btnArrays;
}

@property(nonatomic, retain)NSMutableArray* btnArrays;

-(void)setTabBarState:(BOOL)aHide;
@end
