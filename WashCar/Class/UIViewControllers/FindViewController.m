//
//  FindViewController.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "FindViewController.h"
#import "UIColorDef.h"
#import "WCBaseViewController+Navigation.h"
#import "UIDevice+floatVersion.h"

@interface FindViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* findTableView;
    NSMutableArray* findItems;
}

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabView];
    [self initTabViewDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavBar];
    
    [findTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)initNavBar{
    UIView* navBg = [[UIView alloc] init];
    navBg.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    
    [self setNavBarTitle:@"我的订单" andBgView:navBg titleFrame:CGRectMake(110, 32, 100, 22)];
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
    
    CGRect frame = CGRectMake(0,navBarHight, self.view.frame.size.width, 300);
    
    findTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    findTableView.delegate = self;
    findTableView.dataSource = self;
    
    findTableView.backgroundView = nil;
    findTableView.backgroundColor = [UIColor clearColor];
    
    findTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    findTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:findTableView];
    
}
#if 1
-(void)initTabViewDataSource{
    findItems = [NSMutableArray arrayWithObjects:@"商城", @"车生活", @"活动" ,@"服务", nil];
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
#if 1
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"mineViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (int index=0; index<[findItems count]; index++) {
        if (indexPath.row == index) {
            cell.textLabel.text = [findItems objectAtIndex:index];
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
            NSLog(@"3333333");
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
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
