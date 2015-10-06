//
//  MineTableViewCell.m
//  WashCar
//
//  Created by nate on 15/7/5.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "MineTableViewCell.h"
#import "UIColorDef.h"

@interface MineTableViewCell (){
    UILabel* _labelCell;
    UIImageView* _imageView;
    UIImageView* _disclosureIndicatorView;
    UIView* _downline;
}

@end

@implementation MineTableViewCell

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
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    mask.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mask];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 28, 28)];
    [self.contentView addSubview:_imageView];
    
    _labelCell = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 16, 200, 17)];
    _labelCell.backgroundColor = [UIColor clearColor];
    _labelCell.font = [UIFont boldSystemFontOfSize:17];
    _labelCell.textColor = UIColorFromRGB(0x342302F);
    _labelCell.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_labelCell];
    
    _disclosureIndicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIndicator.png"]];
    _disclosureIndicatorView.frame = CGRectMake(290, 16, 15, 20);
    [self.contentView addSubview:_disclosureIndicatorView];
    
    _downline = [[UIView alloc] initWithFrame:CGRectMake(10, 49, 300, 0.5)];
    _downline.backgroundColor = UIColorWithRGB(221,218,213);
    [self.contentView addSubview:_downline];
}


-(void)updateCell{
    _labelCell.text = _cellData.cellName;
    
    NSString* imageName = nil;
    
    switch (_cellData.cellType) {
        case EnumMinecellWeizhang:
        {
            imageName = @"cellImage.png";
        }
            break;
        case EnumMinecellFankui:
        {
            imageName = @"cellImage.png";
        }
            break;
        case EnumMinecellDingdan:
        {
            imageName = @"cellImage.png";
        }
            break;
        case EnumMinecellMess:
        {
            imageName = @"cellImage.png";
        }
            break;
            
        default:
            break;
    }
    
    _imageView.image = [UIImage imageNamed:imageName];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
}
@end
