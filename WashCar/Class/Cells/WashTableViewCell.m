//
//  WashTableViewCell.m
//  WashCar
//
//  Created by nate on 15/7/8.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WashTableViewCell.h"
#import "UIColorDef.h"

@interface WashTableViewCell()
{
    UIImageView* _leftImage;
    UILabel* _labelText;
    UILabel* _detailLabelText;
    float   _distance;
    UIView* _downLine;
}
@end

@implementation WashTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initContentView];
    }
    return self;
}

-(void)initContentView{
    self.contentView.backgroundColor = UIColorWithRGB(244,243,237);
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    mask.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mask];
    
    
    _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
    [self.contentView addSubview:_leftImage];
    
    _labelText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImage.frame)+10, 16, 200, 17)];
    _labelText.backgroundColor = [UIColor clearColor];
    _labelText.font = [UIFont boldSystemFontOfSize:17];
    _labelText.textColor = UIColorFromRGB(0x342302F);
    _labelText.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_labelText];
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(10, 79, 300, 0.5)];
    _downLine.backgroundColor = UIColorWithRGB(221,218,213);
    [self.contentView addSubview:_downLine];
}

-(void)updataCell{
    [_leftImage setImage:self.cellData.leftImage];
    NSLog(@"labelText=%@",self.cellData.labelText);
    [_labelText setText:self.cellData.labelText];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
}
@end
