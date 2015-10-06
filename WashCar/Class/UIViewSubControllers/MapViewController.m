//
//  MapViewController.m
//  WashCar
//
//  Created by nate on 15/8/25.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "MapViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "UIDevice+floatVersion.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MKAnnotation.h>
#import "PublicDefine.h"

#import <MapKit/MKPlacemark.h>
#import <MapKit/MKMapItem.h>

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    MKMapView*  mapView;
    CLGeocoder *_geocoder;
}

@end

@implementation MapViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.hasNavBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    [self isRunLocalServer];
    
    _geocoder=[[CLGeocoder alloc]init];
    
    [self listPlacemark];
    
    //    [self initMap];
}

-(void)initNavigationBar{
    [self setNavBarTitle:_cpyAddress];
}

-(void)isRunLocalServer{
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"打开“定位服务”来允许“随车宝”确定您的位置" message:@"只有允许定位才能正常使用所有功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alerView show];
        return;
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

-(void)listPlacemark{
    [_geocoder geocodeAddressString:_cpyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark2=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark2=[[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
        
        NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
        
        MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
        
        MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
        
        [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
        
    }];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }
}

#pragma mark - 初始化地图
-(void)initMap{
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mapView.mapType = MKMapTypeStandard;
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    
    
}

//#pragma mark - 地图控件代理方法
//#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
//    if ([annotation isKindOfClass:[MKAnnotation class]]) {
//        static NSString *key1=@"AnnotationKey1";
//        MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:key1];
//        //如果缓存池中不存在则新建
//        if (!annotationView) {
//            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
//            //            annotationView.canShowCallout=true;//允许交互点击
//            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
//            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
//        }
//
//        //修改大头针视图
//        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
//        annotationView.annotation=annotation;
//        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
//
//        return annotationView;
//    }else if([annotation isKindOfClass:[KCCalloutAnnotation class]]){
//        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
//        KCCalloutAnnotationView *calloutView=[KCCalloutAnnotationView calloutViewWithMapView:mapView];
//        calloutView.annotation=annotation;
//        return calloutView;
//    } else {
//        return nil;
//    }
//}
//
//#pragma mark 选中大头针时触发
////点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
//-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
//    KCAnnotation *annotation=view.annotation;
//    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
//        //点击一个大头针时移除其他弹出详情视图
//        //        [self removeCustomAnnotation];
//        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
//        KCCalloutAnnotation *annotation1=[[KCCalloutAnnotation alloc]init];
//        annotation1.icon=annotation.icon;
//        annotation1.detail=annotation.detail;
//        annotation1.rate=annotation.rate;
//        annotation1.coordinate=view.annotation.coordinate;
//        [mapView addAnnotation:annotation1];
//    }
//}
//
//#pragma mark 取消选中时触发
//-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
//    [self removeCustomAnnotation];
//}
//
//#pragma mark 移除所用自定义大头针
//-(void)removeCustomAnnotation{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
//            [_mapView removeAnnotation:obj];
//        }
//    }];
//}





@end
