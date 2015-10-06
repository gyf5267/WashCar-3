//
//  LoginViewController.m
//  WashCar
//
//  Created by nate on 15/7/6.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "LoginViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "UIColorDef.h"
#import "WCQQOAuth.h"

@implementation LoginViewController

#define LoginBtn_Tag 1111
#define RegBtn_tag  2222
#define QQ_Login_Tag 3333

-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = UIColorWithRGB(244,243,237);
    
    [self setNavBarTitle:@"登录"];
    [self initUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)initUI{
    UITextField* accountField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 320, 44)];
    accountField.placeholder = @"请输入手机号码/邮箱";
    accountField.backgroundColor = [UIColor whiteColor];
    accountField.textAlignment = NSTextAlignmentCenter;
    accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:accountField];
    
    UITextField* pwdField = [[UITextField alloc] initWithFrame:CGRectMake(0, 144.5, 320, 44)];
    pwdField.placeholder = @"请填写密码";
    pwdField.secureTextEntry = YES;
    pwdField.backgroundColor = [UIColor whiteColor];
    pwdField.textAlignment = NSTextAlignmentCenter;
    pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:pwdField];
    
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(60, 300, 200, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle: @"立即登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5.0f;
    btn.tag = LoginBtn_Tag;
    [self.view addSubview:btn];
    
    UIButton* regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame = CGRectMake(60, 360, 200, 40);
    regBtn.backgroundColor = [UIColor redColor];
    [regBtn setTitle: @"快速注册" forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [regBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    regBtn.tag = RegBtn_tag;
    regBtn.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:regBtn];
    
    UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 115, 0.5)];
    leftLine.backgroundColor = UIColorWithRGB(221,218,213);
    [self.view addSubview:leftLine];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(110, 460, 100, 40)];
    label.text = @"第三方登录";
    label.textColor = UIColorWithRGB(221,218,213);;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(205, 480, 115, 0.5)];
    rightLine.backgroundColor = UIColorWithRGB(221,218,213);
    [self.view addSubview:rightLine];
    
    UIButton* imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(135, 500, 50, 50)];
    [imageBtn setImage:[UIImage imageNamed:@"buddy_header_icon_qq.png"] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.tag = QQ_Login_Tag;
    [self.view addSubview:imageBtn];
}

-(void)btnClicked:(id)sender{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* btn = (UIButton*)sender;
        
        if (btn) {
            switch (btn.tag) {
                case LoginBtn_Tag:
                {
                    NSLog(@"登录");
                }
                    break;
                case RegBtn_tag:
                {
                    NSLog(@"注册");
                }
                    break;
                case QQ_Login_Tag:
                {
                    NSLog(@"QQ互联登录");
                    [self QQ_Login];
                }
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)QQ_Login{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [[[WCQQOAuth getShareInstance] oAuth] authorize:permissions inSafari:NO];
}

@end
