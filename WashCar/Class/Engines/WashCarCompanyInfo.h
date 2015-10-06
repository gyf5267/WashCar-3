//
//  WashCarCompanyInfo.h
//  WashCar
//
//  Created by nate on 15/8/18.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WashCarCompanyInfo : NSObject

@property (nonatomic, copy) NSString* cpyName;
@property (nonatomic, copy) NSString* cpyAddress;
@property (nonatomic, copy) NSString* cpyPhoto;
@property (nonatomic, retain) NSNumber* km;
@property (nonatomic, retain) NSNumber* longitude;
@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, copy) NSString* telePhone;
@property (nonatomic, retain) NSNumber* salesVolume;

//常规轿车
@property (nonatomic, retain) NSNumber* carType_Car;
@property (nonatomic, retain) NSNumber* car_OriginalPrice;
@property (nonatomic, retain) NSNumber* car_PromotionPrice;

//小型SUV
@property (nonatomic, retain) NSNumber* carType_SmallSUV;
@property (nonatomic, retain) NSNumber* smallSUV_OriginalPrice;
@property (nonatomic, retain) NSNumber* smallSUV_PromotionPrice;

//大中型SUV
@property (nonatomic, retain) NSNumber* carType_LargeSUV;
@property (nonatomic, retain) NSNumber* largeSUV_OriginalPrice;
@property (nonatomic, retain) NSNumber* largeSUV_PromotionPrice;

//评价，技术，态度，环境：评星
@property (nonatomic, retain) NSNumber* evaluationStar;
@property (nonatomic, retain) NSNumber* technologyStar;
@property (nonatomic, retain) NSNumber* attitudeStar;
@property (nonatomic, retain) NSNumber* environmentStar;

//美容:装甲,镀膜,封釉
@property (nonatomic, retain) NSString* armor;
@property (nonatomic, retain) NSNumber* armor_OriginalPrice;
@property (nonatomic, retain) NSNumber* armor_PromotionPrice;

@property (nonatomic, retain) NSString* coating;
@property (nonatomic, retain) NSNumber* coating_OriginalPrice;
@property (nonatomic, retain) NSNumber* coating_PromotionPrice;

@property (nonatomic, retain) NSString* glazing;
@property (nonatomic, retain) NSNumber* glazing_OriginalPrice;
@property (nonatomic, retain) NSNumber* glazing_PromotionPrice;

//评价
@property (nonatomic, retain) NSString* userEvaluation;

@property (nonatomic, retain) NSMutableSet *typeData;
@property (nonatomic, retain) NSMutableSet *beautydata;

@end
