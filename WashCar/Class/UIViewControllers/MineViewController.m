//
//  MineViewController.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "MineViewController.h"
#import "UIColorDef.h"
#import "WCBaseViewController+Navigation.h"
#import "SettingViewController.h"
#import "MessageViewController.h"
#import "UIDevice+floatVersion.h"
#import "MineCellData.h"
#import "MineTableViewCell.h"
#import "LoginViewController.h"
#import "WCNotification.h"
#import "WCQQOAuth.h"
#import "WCUserDefaults.h"
#import "EngineInterface.h"
#import "TestViewController.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate, LoginViewDelegate>
{
    LoginView* _infoView;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabView];
    [self initTabViewDataSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:QQ_Login_Successed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getQQHeadIcon) name:QQ_GetInfo_Notification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataUI:) name:Remove_Cache_Directory_Size_Notification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataClicked:) name:Add_Notification object:nil];
    
}


-(void)dataClicked:(id)sender{
    NSLog(@"MineViewController");
}

-(void)updataUI:(id)sender{
    UILabel* label;
    label.text = [NSString stringWithFormat:@"%fMB", [[EngineInterface shareInstance] getCacheDirectorySize]];
}

-(void)loginSuccessed{
    
    if ([self.navigationController.topViewController isKindOfClass:[LoginViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    BOOL info = [[WCQQOAuth getShareInstance] reqQQUserInfo];
    if (!info) {
        NSLog(@"拉取用户头像失败！！");
    }
}

-(void)getQQHeadIcon{
   NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [operationQueue addOperation:op];
}

- (void)downloadImage
{
    NSString* url = [WCUserDefaults qqIconUrl];
    NSURL *imageUrl = [NSURL URLWithString:url];
    NSData* data = [NSData dataWithContentsOfURL:imageUrl];
    if (data) {
        NSString* filePath = [WCUserDefaults createCachesDirectoryAndFile:@"image/" fileName:@"icon.rtf"];
        
        [data writeToFile:filePath atomically:YES];
        
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.infoView.imageView.image = image;
            });
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initQQ_Logo{
    NSString* url = [WCUserDefaults qqIconUrl];
    if (url != nil) {
        NSString* filePath = [WCUserDefaults createCachesDirectoryAndFile:@"image/" fileName:@"icon.rtf"];
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        if (data && data.length>0) {
            self.infoView.imageView.image = [UIImage imageWithData:data];
        }else{
            [self getQQHeadIcon];
        }
    }else{
        self.infoView.imageView.image = [UIImage imageNamed:@"addressbook_list_user.png"];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self initUI];
    [self initQQ_Logo];
    [_mineTabView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)initNavBar{
    UIView* navBg = [[UIView alloc] init];
    navBg.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    
    [self setNavBarTitle:@"我" andBgView:navBg titleFrame:CGRectMake(110, 32, 100, 22)];
    
    [self setNavRigthButtonWithImageName:@"home_recently_play_btn.png" frame:CGRectMake(320-27-9, 9, 27, 29) target:self action:@selector(rightBtnClicked)];
}

-(void)rightBtnClicked{
    SettingViewController* settingCon = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingCon animated:YES];
}

-(void)initTabView{
    float navBarHight = 0.0f;
    NSLog(@"UIDevice version=%ld", (long)[UIDevice deviceVersion]);
    if ([UIDevice deviceVersion] < 7.0) {
        navBarHight = 44.0f;
    }
    
    float offset = 0.0f;
    if ([UIDevice deviceVersion] >= 7.0) {
        offset = 64.0f;
    }
    
    CGRect frame = CGRectMake(0,navBarHight, self.view.frame.size.width, 520);
    
    _mineTabView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _mineTabView.delegate = self;
    _mineTabView.dataSource = self;
    
    _mineTabView.backgroundView = nil;
    _mineTabView.backgroundColor = [UIColor clearColor];
    
    _mineTabView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _mineTabView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mineTabView];
    
    self.infoView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    _infoView.delegate = self;
    _mineTabView.tableHeaderView = self.infoView;
    
}
#if 0
-(void)initTabViewDataSource{
    _tabViewItemArray = [NSMutableArray arrayWithObjects:@"违章查询", @"我的订单", @"意见反馈" ,@"消息中心", nil];
}
#else
-(void)initTabViewDataSource{
    _tabViewItemArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    MineCellData* data1 = [[MineCellData alloc] init];
    data1.cellName = @"违章查询";
    data1.cellType = EnumMinecellWeizhang;
    [_tabViewItemArray addObject:data1];
    
    MineCellData* data2 = [[MineCellData alloc] init];
    data2.cellName = @"我的订单";
    data2.cellType = EnumMinecellDingdan;
    [_tabViewItemArray addObject:data2];
    
    MineCellData* data3 = [[MineCellData alloc] init];
    data3.cellName = @"意见反馈";
    data3.cellType = EnumMinecellFankui;
    [_tabViewItemArray addObject:data3];
    
    MineCellData* data4 = [[MineCellData alloc] init];
    data4.cellName = @"消息中心";
    data4.cellType = EnumMinecellMess;
    [_tabViewItemArray addObject:data4];
}
#endif

-(void)initUI{
#if 0
    UIView* loginBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    loginBgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:loginBgView];
    
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(128, 80, 64, 64);
    [loginBtn setImage:[UIImage imageNamed:@"touxiang.png"] forState:UIControlStateNormal];
    
    [loginBgView addSubview:loginBtn];
#endif
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
#if 0
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"mineViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (int index=0; index<[_tabViewItemArray count]; index++) {
        if (indexPath.row == index) {
            cell.textLabel.text = [_tabViewItemArray objectAtIndex:index];
            NSString* image = [NSString stringWithFormat:@"cellImage_%d.png", index+1];
            cell.imageView.image = [UIImage imageNamed:image];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}
#else
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"mineViewCell";
    MineTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (int index=0; index<[_tabViewItemArray count]; index++) {
        if (indexPath.row == index) {
            cell.cellData = [_tabViewItemArray objectAtIndex:index];
        }
    }
    
    [cell updateCell];
    return cell;
}

#endif


#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"0000000000");
        }
            break;
        case 1:
        {
             NSLog(@"11111111");
        }
            break;
        case 2:
        {
             NSLog(@"222222222");
        }
            break;
        case 3:
        {
            MessageViewController* messCon = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:messCon animated:YES];
             NSLog(@"3333333");
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
#pragma mark -LoginViewDelegate
-(void)loginBtnClicked{
#if 1
    LoginViewController* loginCon = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginCon animated:YES];
#else
    TestViewController* test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
#endif
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
