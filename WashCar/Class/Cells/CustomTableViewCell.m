//
//  CustomTableViewCell.m
//  WashCar
//
//  Created by nate on 15/9/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "PublicDefine.h"
#import "UIColorDef.h"

@interface CustomTableViewCell (){
    UIView* maskView;
    UIImageView* imageView;
    UILabel* customName;
    UIImageView* sexView;
    UIView* _downLine;
    
    UIImageView*  swipeView;
}

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:maskView];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 60)];
    [maskView addSubview:imageView];
    
    customName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 10, 200, 30)];
    customName.backgroundColor = [UIColor clearColor];
    customName.font = [UIFont boldSystemFontOfSize:17];
    customName.textColor = UIColorFromRGB(0x342302F);
    customName.textAlignment = NSTextAlignmentLeft;
    [maskView addSubview:customName];
    
    sexView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 45, 15, 15)];
    [maskView addSubview:sexView];
    
    swipeView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-60-10, 10, 60, 60)];
    swipeView.userInteractionEnabled = YES;
    swipeView.backgroundColor = [UIColor clearColor];
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureEvent:)];
    swipe.numberOfTouchesRequired = 1;
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [swipeView addGestureRecognizer:swipe];
    
    [maskView addSubview:swipeView];
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenWidth, 0.5)];
    _downLine.backgroundColor = UIColorWithRGB(221,218,213);
    [maskView addSubview:_downLine];
    
}

-(void)swipeGestureEvent:(id)sender{
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 10, 150, 60)];
    
    bgView.backgroundColor = [UIColor redColor];
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    //改变它的frame的x,y的值
    bgView.frame=CGRectMake(ScreenWidth-150-10,10, 150,60);
    
    
    [UIView commitAnimations];
    
    [maskView addSubview:bgView];
}

-(void)updateMyCell{
    imageView.image = [UIImage imageNamed:_myData.imageName];
    customName.text = _myData.nickName;
    
    if (_myData.sex == 1) {
        sexView.image = [UIImage imageNamed:@"baby_icon.png"];
    }else{
        sexView.image = [UIImage imageNamed:@"family_icon.png"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
