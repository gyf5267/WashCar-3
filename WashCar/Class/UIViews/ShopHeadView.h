//
//  ShopHeadView.h
//  WashCar
//
//  Created by nate on 15/8/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WashCarCompanyInfo.h"

@protocol ShopHeadViewDelegate <NSObject>

-(void)collectionClicked:(id)sender;
-(void)phoneClicked:(id)sender;
-(void)addressClicked:(id)sender;

@end

@interface ShopHeadView : UIView

@property (nonatomic, strong)WashCarCompanyInfo* info;

@property(nonatomic, weak)id<ShopHeadViewDelegate> delegate;


-(void)updateCellContent;

@end
