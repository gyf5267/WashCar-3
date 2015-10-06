//
//  ShopHeadView.m
//  WashCar
//
//  Created by nate on 15/8/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "ShopHeadView.h"
#import "PublicDefine.h"
#import "UIColorDef.h"

@interface ShopHeadView ()
{
    UIImageView* imageViw;
    UILabel*    cpyName;
    UIImageView* starView;
    UILabel*    fenLabel;
    UILabel* XSLabel;
    UIButton* btn;
    UILabel* addressLabel;
}

@end

@implementation ShopHeadView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initHeadViewUI];
    }
    return self;
}

-(void)initHeadViewUI{
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 145)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bgView];
    
    imageViw = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 90)];
    imageViw.layer.cornerRadius = 5.0f;
    imageViw.layer.masksToBounds = YES;
    [bgView addSubview:imageViw];
    
    cpyName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageViw.frame)+10, 5, ScreenWidth, 44)];
    
    cpyName.backgroundColor = [UIColor clearColor];
    cpyName.textAlignment = NSTextAlignmentLeft;
    [cpyName setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:cpyName];
    
    starView = [[UIImageView alloc] init];
    [bgView addSubview:starView];
    
    fenLabel = [[UILabel alloc] init];
    fenLabel.backgroundColor = [UIColor clearColor];
    [fenLabel setFont:[UIFont systemFontOfSize:12]];
    [bgView addSubview:fenLabel];
    
    XSLabel = [[UILabel alloc] init];
    XSLabel.backgroundColor = [UIColor clearColor];
    [XSLabel setFont:[UIFont systemFontOfSize:12]];
    [bgView addSubview:XSLabel];
    
    btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(ScreenWidth-60-20, 70, 60, 30);
    btn.layer.cornerRadius = 5.0f;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"收藏" forState:UIControlStateNormal];
    btn.tag = 2000;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    UILabel* pj_count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageViw.frame)+10, CGRectGetMaxY(imageViw.frame)-20, 100, 20)];
    pj_count.backgroundColor = [UIColor clearColor];
    pj_count.text = [NSString stringWithFormat:@"评价:192"];
    [pj_count setFont:[UIFont systemFontOfSize:12.0f]];
    [bgView addSubview:pj_count];
    
    UIView* upline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageViw.frame)+10, ScreenWidth, 0.5)];
    upline.backgroundColor = UIColorWithRGB(221,218,213);
    [bgView addSubview:upline];
    
    UIImageView* addressView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(upline.frame), 32, 32)];
    addressView.image = [UIImage imageNamed:@"address.png"];
    [bgView addSubview:addressView];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressView.frame), CGRectGetMaxY(upline.frame)+2, 200, 30)];
    addressView.backgroundColor = [UIColor clearColor];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    [addressLabel setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:addressLabel];
    
    UIButton* addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.frame = CGRectMake(ScreenWidth-2*35-20, CGRectGetMaxY(upline.frame), 35, 32);
    addressBtn.tag = 3000;
    [addressBtn setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
    [addressBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addressBtn];
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-35-5-7.5, CGRectGetMaxY(upline.frame), 0.5, 35)];
    line.backgroundColor = UIColorWithRGB(221,218,213);
    [bgView addSubview:line];
    
    UIButton* phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(ScreenWidth-35-5, CGRectGetMaxY(upline.frame), 35, 32);
    [phoneBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [phoneBtn setImage:[UIImage imageNamed:@"phone.png"] forState:UIControlStateNormal];
    phoneBtn.tag = 1000;
    [bgView addSubview:phoneBtn];
    
    UIView* downline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addressView.frame)+2, ScreenWidth, 0.5)];
    downline.backgroundColor = UIColorWithRGB(221,218,213);
    [bgView addSubview:downline];
    
}

-(void)btnClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        UIButton* btnObject = (UIButton*)sender;
        
        switch (btnObject.tag) {
            case 1000:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(phoneClicked:)]) {
                    [_delegate phoneClicked:sender];
                }
            }
                
                break;
            case 2000:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(collectionClicked:)]) {
                    [_delegate collectionClicked:sender];
                }
            }
                break;
            case 3000:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(addressClicked:)]) {
                    [_delegate addressClicked:sender];
                }
            }
                break;
                
            default:
                break;
        }

    }
}

-(void)updateCellContent{
    imageViw.image = [UIImage imageNamed:_info.cpyPhoto];
    cpyName.text = _info.cpyName;
    
    int num = _info.evaluationStar.intValue;
    
    starView.frame = CGRectMake(CGRectGetMaxX(imageViw.frame)+10, 45, 16*num, 20);
    NSString* imageName = [NSString stringWithFormat:@"Star-%d.png", num];
    starView.image = [UIImage imageNamed:imageName];
    
    fenLabel.frame = CGRectMake(CGRectGetMaxX(starView.frame)+5, 45, 30, 20);
    fenLabel.text = [NSString stringWithFormat:@"%d分 | ",num];
    
    XSLabel.frame = CGRectMake(CGRectGetMaxX(fenLabel.frame), 45, 60, 20);
    XSLabel.text = [NSString stringWithFormat:@"销量:%d", _info.salesVolume.intValue];
    addressLabel.text = _info.cpyAddress;
    
    
}
@end
