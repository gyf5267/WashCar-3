//
//  CpyDetailTableViewCell.m
//  WashCar
//
//  Created by nate on 15/8/28.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "CpyDetailTableViewCell.h"
#import "PublicDefine.h"
#import "UIColorDef.h"

@interface CpyDetailTableViewCell ()
{
    UIImageView* imageView;
    UILabel* titleLabel;
    UILabel* titleDetailLabel;
    
    UILabel* discountLabel;
    UILabel* originalLabel;
}

@end

@implementation CpyDetailTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initCellUI];
    }
    return self;
}

-(void)initCellUI{
    self.contentView.backgroundColor = UIColorWithRGB(244,243,237);
    
    UIView* cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    cellView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cellView];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 18, 18)];
    [cellView addSubview:imageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 5, 200, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    [cellView addSubview:titleLabel];
    
    discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-70, 2, 60, 20)];
    discountLabel.backgroundColor = [UIColor clearColor];
    discountLabel.textColor = [UIColor orangeColor];
    discountLabel.font = [UIFont systemFontOfSize:12];
    discountLabel.textAlignment = NSTextAlignmentCenter;
    
    [cellView addSubview:discountLabel];
    
    originalLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-65, 20, 60, 20)];
    originalLabel.backgroundColor = [UIColor clearColor];
//    originalLabel.textColor = UIColorWithRGB(221,218,213);
    originalLabel.font = [UIFont systemFontOfSize:10];
    originalLabel.textAlignment = NSTextAlignmentCenter;
    
    [cellView addSubview:originalLabel];
    
    
    titleDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 35, 250, 20)];
    titleDetailLabel.backgroundColor = [UIColor clearColor];
    titleDetailLabel.font = [UIFont systemFontOfSize:12];
    
    [cellView addSubview:titleDetailLabel];
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, ScreenWidth, 0.5)];
    line.backgroundColor = UIColorWithRGB(221,218,213);
    [cellView addSubview:line];
}

-(void)updateDetailCell{
    imageView.image = [UIImage imageNamed:_imageName];
    titleLabel.text = _titleName;
    titleDetailLabel.text = _titleDetail;
    
    discountLabel.text = [NSString stringWithFormat:@"￥%.2f", _discountPrice];
    
//画文字中间线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSString* original = [NSString stringWithFormat:@"%.2f",_originalPrice];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:original attributes:attribtDic];
    
    originalLabel.attributedText = attribtStr;
   
//画文字的下边线
//    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f",_originalPrice]];
//    
//    NSRange contentRange = {0,[content length]};
//    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//    
//    originalLabel.attributedText = content;
    //[NSString stringWithFormat:@"%.2f",_originalPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
