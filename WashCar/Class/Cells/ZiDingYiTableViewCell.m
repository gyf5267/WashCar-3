//
//  ZiDingYiTableViewCell.m
//  Wash_Car_Club
//
//  Created by 中软国际013 on 15/8/11.
//  Copyright (c) 2015年 中软国际027. All rights reserved.
//

#import "ZiDingYiTableViewCell.h"
#import "PublicDefine.h"
#import "PublicDefine.h"
#import "UIColorDef.h"

@interface ZiDingYiTableViewCell ()
{
    UILabel* _labelText;

    UILabel *_la2;
    UILabel *_la3;
    UILabel *_la4;
    UIImageView *_leftImage;
    
    UIView* _downLine;
}

@end

@implementation ZiDingYiTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.contentView.backgroundColor = UIColorWithRGB(244,243,237);
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    mask.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mask];

    _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
    _leftImage.layer.cornerRadius = 5.0f;
    _leftImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_leftImage];
    
    _labelText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImage.frame)+10, 16, 200, 17)];
    _labelText.backgroundColor = [UIColor clearColor];
    _labelText.font = [UIFont boldSystemFontOfSize:17];
    _labelText.textColor = [UIColor redColor];
    _labelText.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_labelText];

    
    _la2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImage.frame)+10, CGRectGetMaxY(_labelText.frame), 200, 24)];
    _la2.textColor = [UIColor brownColor];
    _la2.backgroundColor = [UIColor clearColor];
    _la2.font = [UIFont boldSystemFontOfSize:14];
    
    [self.contentView addSubview: _la2];
    
    _la3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImage.frame)+10, 53, 200, 23)];
    [self.contentView addSubview: _la3];
    
    _la4 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-60, 3, 80, 14)];
    _la4.backgroundColor = [UIColor clearColor];
    _la4.font = [UIFont boldSystemFontOfSize:14];
    _la4.textColor = UIColorWithRGB(221,218,213);//[UIColor lightGrayColor];
    [self.contentView addSubview: _la4];
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(10, 79, 300, 0.5)];
    _downLine.backgroundColor = UIColorWithRGB(221,218,213);
    [self.contentView addSubview:_downLine];
}

-(void)updataCell{
    _labelText.text = _cellData.cpyName;
    _la2.text = _cellData.cpyAddress;
    
    NSString* star = nil;
    
    switch (_cellData.evaluationStar.intValue) {
        case 1:
        {
            star = [NSString stringWithFormat:@"✨"];
        }
            break;
        case 2:
        {
            star = [NSString stringWithFormat:@"✨✨"];
        }
            break;
        case 3:
        {
            star = [NSString stringWithFormat:@"✨✨✨"];
        }
            break;
        case 4:
        {
            star = [NSString stringWithFormat:@"✨✨✨✨"];
        }
            break;
        case 5:
        {
            star = [NSString stringWithFormat:@"✨✨✨✨✨"];
        }
            break;
            
        default:
            break;
    }
    _la3.text = [NSString stringWithFormat:@"%@ %d分",star ,_cellData.evaluationStar.intValue];
    
    _la4.text = [NSString stringWithFormat:@"%.2fKM",_cellData.km.floatValue];
    _leftImage.image = [UIImage imageNamed:_cellData.cpyPhoto];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}



@end
