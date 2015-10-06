//
//  WashCarDetailViewController.m
//  WashCar
//
//  Created by nate on 15/8/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WashCarDetailViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "WashCarCompanyInfo.h"
#import "EngineInterface.h"
#import "ShopHeadView.h"
#import "PublicDefine.h"
#import "MapViewController.h"

#import <MapKit/MKPlacemark.h>
#import <MapKit/MKMapItem.h>
#import <MapKit/MKTypes.h>
#import "UIDevice+floatVersion.h"
#import "CarTypeData.h"
#import "CpyDetailTableViewCell.h"
#import "UIColorDef.h"
#import "UtilityClass.h"
#import "CarTypeDataInfo.h"
#import "BeautyData.h"

@interface WashCarDetailViewController ()<ShopHeadViewDelegate,CLLocationManagerDelegate>
{
    WashCarCompanyInfo* cpyInfo;
    ShopHeadView* headView;
    CLGeocoder *_geocoder;
    
    CLLocationManager *locationManager;
    
    //车类型数组section
    NSMutableArray* carTypeArray;
    
    //美容数组section
    NSMutableArray* beautyArray;
    
    //每个section 的标题
    NSMutableArray* titleArray;
    
    //section 的数组
    NSMutableArray* sectionArray;
}

@end

@implementation WashCarDetailViewController

-(id)init{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _tableView = nil;
    
    [carTypeArray removeAllObjects];
    carTypeArray = nil;
    
    [beautyArray removeAllObjects];
    beautyArray = nil;
    
    [titleArray removeAllObjects];
    titleArray = nil;
    [sectionArray removeAllObjects];
    sectionArray = nil;
    
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
    self.hasNavBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    cpyInfo = [[EngineInterface shareInstance] fetchCpyInfoWithIndex:_cpyName];
    [self initNavigationBar];
    [self dataSource];
    
    _tableView.tableHeaderView = [self tableViewHead];
}


-(ShopHeadView*)tableViewHead{
    if (headView == nil) {
        headView = [[ShopHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 165)];
        headView.delegate = self;
        headView.info = cpyInfo;
        
        [headView updateCellContent];
    }
    return headView;
}
#pragma mark - ShopHeadViewDelegate
-(void)collectionClicked:(id)sender{
    
}

-(void)phoneClicked:(id)sender{
#if TARGET_IPHONE_SIMULATOR
    UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请使用真机测试这个功能！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alerView show];
    
#else
    NSString* phoneNumber = @"10086";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNumber]]];
#endif
    
    
}

-(void)addressClicked:(id)sender{
#if 0
    MapViewController* mapViewController = [[MapViewController alloc] init];
    mapViewController.cpyAddress = cpyInfo.cpyAddress;
    [self.navigationController pushViewController:mapViewController animated:YES];
#else
    if (![self isRunLocalServer]) {
        return;
    }
    _geocoder=[[CLGeocoder alloc]init];
    
    [_geocoder geocodeAddressString:cpyInfo.cpyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark2=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark2=[[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
        
        NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
        
        MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
        
        MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
        
        [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
        
    }];
#endif
}

#pragma mark - 初始化NavigationBar
-(void)initNavigationBar{
    [self setNavBarTitle:_cpyName];
}

-(BOOL)isRunLocalServer{
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"打开“定位服务”来允许“随车宝”确定您的位置" message:@"只有允许定位才能正常使用所有功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alerView show];
        return NO;
    }
    
    float version = [UIDevice deviceVersion];
    locationManager = [[CLLocationManager alloc] init];
    
    if (version>8.0) {
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [locationManager requestWhenInUseAuthorization];
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
            //设置代理
            locationManager.delegate=self;
            //设置定位精度
            locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;//十米定位一次
            locationManager.distanceFilter=distance;
            //启动跟踪定位
            [locationManager startUpdatingLocation];
        }
        
    }else{
        //启动跟踪定位
        [locationManager startUpdatingLocation];
    }
    return YES;
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [locationManager stopUpdatingLocation];
}

-(void)dataSource{
    titleArray = [NSMutableArray array];
    [titleArray addObject:@"洗车套餐"];
    [titleArray addObject:@"美容套餐"];
    
    carTypeArray = [NSMutableArray array];
    [carTypeArray addObjectsFromArray:cpyInfo.typeData.allObjects];
    
    beautyArray = [NSMutableArray array];
    [beautyArray addObjectsFromArray:cpyInfo.beautydata.allObjects];
    
    sectionArray = [NSMutableArray array];
    [sectionArray addObject:carTypeArray];
    [sectionArray addObject:beautyArray];
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return [titleArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionArray objectAtIndex:section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel* sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 29.5)];
    sectionTitle.backgroundColor = [UIColor clearColor];
    sectionTitle.text = [titleArray objectAtIndex:section];
    sectionTitle.font = [UIFont systemFontOfSize:14];
    sectionTitle.textColor = [UIColor blueColor];
    sectionTitle.textAlignment = NSTextAlignmentLeft;
    
    [sectionView addSubview:sectionTitle];
    
    UIView* upline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    upline.backgroundColor = UIColorWithRGB(221,218,213);;
    [sectionView addSubview:upline];
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 0.5)];
    line.backgroundColor = UIColorWithRGB(221,218,213);;
    [sectionView addSubview:line];
    
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString* cellName = @"cellName";
    
    //首先根据标识去缓存池取
    CpyDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    //如果缓存池没有到则重新创建并放到缓存池中
    if (cell == nil) {
        cell = [[CpyDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (indexPath.section == 0) {
        cell.imageName = @"wash.png";
    }else{
        cell.imageName = @"beauty.png";
    }
    
    //注：此处数据就写死啦~~~~
    if (indexPath.section == 0) {
        
        NSMutableArray* list = [sectionArray objectAtIndex:indexPath.section];
        CarTypeDataInfo* info = (CarTypeDataInfo*)[list objectAtIndex:indexPath.row];
        switch ([info.type intValue]) {
            case carType_car:
            {
                cell.titleName = @"vip免费洗车(轿车)";
                cell.titleDetail = @"vip会员免费，温水洗车";
                cell.discountPrice = [info.originalPrice floatValue];
                cell.originalPrice = [info.discountPrice floatValue];
            }
                break;
            case carType_Small_SUV:
            {
                cell.titleName = @"vip免费洗车(小型SUV)";
                cell.titleDetail = @"vip会员免费，温水洗车，参考车型Q5，X3等";
                cell.discountPrice = [info.originalPrice floatValue];
                cell.originalPrice = [info.discountPrice floatValue];
                
            }
                break;
            case carType_Large_medium_SUV:
            {
                cell.titleName = @"vip免费洗车(大中型SUV)";
                cell.titleDetail = @"vip会员免费，温水洗车，参考车型Q7，X5等";
                cell.discountPrice = [info.originalPrice floatValue];
                cell.originalPrice = [info.discountPrice floatValue];
                
            }
                break;
                
            default:
                break;
        }
    }else{
        NSMutableArray* list = [sectionArray objectAtIndex:indexPath.section];
        BeautyData* info = (BeautyData*)[list objectAtIndex:indexPath.row];
        switch ([info.type intValue]) {
            case beautyType_armor:
            {
                cell.titleName = @"美车打蜡";
                cell.titleDetail = @"vip会员折扣价，免费赠送5次洗车";
                cell.discountPrice = [info.discountPrice floatValue];
                cell.originalPrice = [info.originalPrice floatValue];
            }
                break;
            case beautyType_coating:
            {
                cell.titleName = @"全车抛光";
                cell.titleDetail = @"vip会员折扣价，免费赠送10次洗车";
                cell.discountPrice = [info.discountPrice floatValue];
                cell.originalPrice = [info.originalPrice floatValue];
                
            }
                break;
            case beautyType_glazing:
            {
                cell.titleName = @"汽车贴膜";
                cell.titleDetail = @"vip会员折扣价，免费赠送20次洗车";
                cell.discountPrice = [info.discountPrice floatValue];
                cell.originalPrice = [info.originalPrice floatValue];
                
            }
                break;
                
            default:
                break;
        }
    }
    
    
    [cell updateDetailCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"122222222");
}
@end
