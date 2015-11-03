//
//  WashViewController.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WashViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "UIColorDef.h"
#import "HistroyViewController.h"
#import "UIDevice+floatVersion.h"

#import "WashCellData.h"
#import "WashTableViewCell.h"
#import "ActivityDetailView.h"
#import "QRCodeView.h"
#import "PublicDefine.h"
#import "ZBarSDK.h"
#import "ZiDingYiTableViewCell.h"
#import "EngineInterface.h"
#import "WCNetWorkStatsManager.h"
#import "NoNetWorkView.h"
#import "WCLoadingView.h"
#import "WashCarDetailViewController.h"
#import "WCNotification.h"

@interface WashViewController ()<UITableViewDataSource, UITableViewDelegate, QRCodeViewDelegate, UIActionSheetDelegate>
{
    UIActionSheet* _actionSheet;
    NSMutableArray* currectArray;
    NoNetWorkView* _errorView;
    WCLoadingView* _loadingView;
    NSTimer* _timer;
}

@end

@implementation WashViewController

#define QR_Code_Tag 1000

-(id)init{
    self = [super init];
    if (self) {
        self.style = UITableViewStylePlain;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //延长启动闪屏的时间
    [NSThread sleepForTimeInterval:2.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSucceed:) name:Add_Cpy_Info_Notification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addData:) name:Add_Notification object:nil];
    
    [self initTabView];
    // Do any additional setup after loading the view.
}

-(void)addData:(id)sender{
    NSLog(@"WashViewController");
}

-(void)addSucceed:(id)sender{
    
}

-(void)initData{
    if (![WCNetWorkStatsManager isConnectionAvailable]) {
        
        _errorView = [[NoNetWorkView alloc] initWithError:nil target:self action:@selector(tryAction:)];
        _errorView.frame = self.view.bounds;
        
        [self.view addSubview:_errorView];
        
    }else{
        [self initTabViewDataSource];
    }
}

-(void)tryAction:(id)sender{
    [_errorView removeFromSuperview];
    
    [self showLoadingView];
}

-(void)showLoadingView{
    if (_loadingView != nil) {
        [_loadingView removeFromSuperview];
    }
    
    _loadingView = [[WCLoadingView alloc] init];
    
    _loadingView.frame = self.view.bounds;
    
    [self.view addSubview:_loadingView];
    
    //延时5秒 拉取数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadingData:nil];
    });
    
}

-(void)loadingData:(id)sender{
    [self removeWaiting];
    
    [self initTabViewDataSource];
    
    [_tableView reloadData];
    
}

- (void)removeWaiting{
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self initData];
    [_tableView reloadData];
    
//    [self initUI];
//    [_tableView reloadData];
//    self.useHeaderRefreshView = YES;
//    self.useFooterRefreshView = YES;
//    CGRect tableViewframe = _tableView.frame;
//    tableViewframe.size.height -= 65;
//    _tableView.frame = tableViewframe;

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)initNavBar{
    UIView* navBg = [[UIView alloc] init];
    navBg.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    
    [self setNavBarTitle:@"洗车联盟" andBgView:navBg titleFrame:CGRectMake(110, 32, 100, 22)];
    
    [self setLeftButtonWithImageName:@"searchIcon.png" frame:CGRectMake(9, 9, 27, 29) target:self action:@selector(leftBtnClicked)];
    
    [self setNavRigthButtonWithImageName:@"home_recently_play_btn.png" frame:CGRectMake(320-27-9, 9, 27, 29) target:self action:@selector(rightBtnClicked)];
}

-(void)btnClicked:(id)sender{
    
}


-(void)rightBtnClicked{
    if (_actionSheet == nil) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"定位(大连)" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全城", @"中山区",@"西岗区",@"沙河口区",@"甘井子区",  nil];
        _actionSheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    }
    
    [_actionSheet showInView:self.view];
}

-(BOOL)currectTabViewDataSourceWithAddress:(NSString*)address{
    if (address != nil) {
        if ([address isEqualToString:@"取消"]) {
            return NO;
        }
        if ([address isEqualToString:@"全城"]) {
            if (currectArray.count == _tableViewDataArray.count) {
                return NO;
            }else{
                [currectArray removeAllObjects];
                
                for (id object in _tableViewDataArray) {
                    WashCarCompanyInfo* info = (WashCarCompanyInfo*)object;
                    [currectArray addObject:info];
                    
                }
                return YES;
            }
        }
        [currectArray removeAllObjects];
        
        for (id object in _tableViewDataArray) {
            WashCarCompanyInfo* info = (WashCarCompanyInfo*)object;
            
            if ([address isEqualToString:info.cpyAddress]) {
                [currectArray addObject:info];
            }
        }
        return YES;
    }
    return NO;
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString* address = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    BOOL isUpdata = [self currectTabViewDataSourceWithAddress:address];
    if (isUpdata) {
        [_tableView reloadData];
    }
    
}


//创建二维码
-(void)leftBtnClicked{
    QRCodeView* qrView = [[QRCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    qrView.delegate = self;
    qrView.tag = QR_Code_Tag;
    
    [self.view.window addSubview:qrView];
}

//扫描二维码
-(void)qrcode_Scanning{
    //    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    //    reader.readerDelegate = self;
    //    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    //
    //    ZBarImageScanner *scanner = reader.scanner;
    //
    //    [scanner setSymbology: ZBAR_I25
    //                   config: ZBAR_CFG_ENABLE
    //                       to: 0];
}

#pragma mark - ZBarReaderDelegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    
}

#pragma mark - QRCodeViewDelegate
-(void)clickedDisapper{
    QRCodeView* qrView = (QRCodeView*)[self.view.window viewWithTag:QR_Code_Tag];
    
    if (qrView) {
        [qrView removeFromSuperview];
        qrView = nil;
    }
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
    
    //CGRect frame = CGRectMake(0,navBarHight, self.view.frame.size.width, 520);
    
    //_tableView.frame = frame;
//    _mineTabView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
//    _mineTabView.delegate = self;
//    _mineTabView.dataSource = self;
//    
//    
//    _mineTabView.backgroundView = nil;
//    _mineTabView.backgroundColor = UIColorFromRGB(0xEEEEEE);
//    
//    _mineTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    _mineTabView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:_mineTabView];
    
    _tableView.tableHeaderView = [self tableViewHeaderView];
    
}

- (UIView *)tableViewHeaderView{
    if (_bannerController==nil) {
        self.bannerController = [[WCBannerViewController alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
        [self addChildViewController:_bannerController];
    }
    return _bannerController.view;
}
#if 0
-(void)initTabViewDataSource{
    _tabViewItemArray = [NSMutableArray arrayWithObjects:@"违章查询", @"我的订单", @"意见反馈" ,@"消息中心", nil];
}
#else
-(void)initTabViewDataSource{
    _tableViewDataArray = [[EngineInterface shareInstance] fetchCpyInfo:nil];
    currectArray = [[NSMutableArray alloc] initWithArray:_tableViewDataArray];
    
#if 0
    WashCellData* data1 = [[WashCellData alloc] init];
    UIImage* image = [UIImage imageNamed:@"pic-1.png"];
    data1.leftImage = image;
    data1.labelText = @"万马汽车美容";
    data1.detailLabelText = @"西岗区胜利路62号";
    data1.distance = 189;
    [_tabViewItemArray addObject:data1];
    
    WashCellData* data2 = [[WashCellData alloc] init];
    data2.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data2.labelText = @"大连东升汽车美容";
    data2.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data2.distance = 29.5;
    [_tabViewItemArray addObject:data2];
    
    
    WashCellData* data3 = [[WashCellData alloc] init];
    data3.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data3.labelText = @"米其林汽车";
    data3.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data3.distance = 329.5;
    [_tabViewItemArray addObject:data3];
    
    WashCellData* data4 = [[WashCellData alloc] init];
    data4.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data4.labelText = @"新航汽车";
    data4.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data4.distance = 88.5;
    [_tabViewItemArray addObject:data4];
    
    WashCellData* data5 = [[WashCellData alloc] init];
    data5.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data5.labelText = @"车酷汽车理容中心";
    data5.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data5.distance = 71.6;
    [_tabViewItemArray addObject:data5];
    
    WashCellData* data6 = [[WashCellData alloc] init];
    data6.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data6.labelText = @"德士龙汽车会所";
    data6.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data6.distance = 300;
    [_tabViewItemArray addObject:data6];
    
    WashCellData* data7 = [[WashCellData alloc] init];
    data7.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data7.labelText = @"万马汽车美容";
    data7.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data7.distance = 930.5;
    [_tabViewItemArray addObject:data7];
    
    WashCellData* data8 = [[WashCellData alloc] init];
    data8.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data8.labelText = @"万马汽车美容";
    data8.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data8.distance = 434.5;
    [_tabViewItemArray addObject:data8];
    
    WashCellData* data9 = [[WashCellData alloc] init];
    data9.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data9.labelText = @"万马汽车美容";
    data9.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data9.distance = 200.3;
    [_tabViewItemArray addObject:data9];
    
    WashCellData* data10 = [[WashCellData alloc] init];
    data10.leftImage = [UIImage imageNamed:@"pic-1.png"];
    data10.labelText = @"万马汽车美容";
    data10.detailLabelText = @"高新园区龙潭街道小龙塘村";
    data10.distance = 59.5;
    [_tabViewItemArray addObject:data10];
    
#endif
    
    
    
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
    return currectArray.count;
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
    
    static NSString* identifier = @"washCell";
    ZiDingYiTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ZiDingYiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (int index=0; index<[currectArray count]; index++) {
        if (indexPath.row == index) {
            cell.cellData = [currectArray objectAtIndex:index];
        }
    }
    
    [cell updataCell];
    return cell;
}

#endif


#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[EngineInterface shareInstance] add_Notifaction];
    
    WashCarDetailViewController* detailView = [[WashCarDetailViewController alloc] init];
    
    WashCarCompanyInfo* info = [currectArray objectAtIndex:indexPath.row];
    
    detailView.cpyName = info.cpyName;
    
    [self.navigationController pushViewController:detailView animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
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
