//
//  CompanyInfo.h
//  WashCar
//
//  Created by nate on 15/8/28.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarBeautyData, CarTypeData;

@interface CompanyInfo : NSManagedObject

@property (nonatomic, retain) NSString * armor;
@property (nonatomic, retain) NSNumber * armor_OriginalPrice;
@property (nonatomic, retain) NSNumber * armor_PromotionPrice;
@property (nonatomic, retain) NSNumber * attitudeStar;
@property (nonatomic, retain) NSNumber * car_OriginalPrice;
@property (nonatomic, retain) NSNumber * car_PromotionPrice;
@property (nonatomic, retain) NSNumber * carType_Car;
@property (nonatomic, retain) NSNumber * carType_LargeSUV;
@property (nonatomic, retain) NSNumber * carType_SmallSUV;
@property (nonatomic, retain) NSString * coating;
@property (nonatomic, retain) NSNumber * coating_OriginalPrice;
@property (nonatomic, retain) NSNumber * coating_PromotionPrice;
@property (nonatomic, retain) NSString * cpyAddress;
@property (nonatomic, retain) NSString * cpyName;
@property (nonatomic, retain) NSString * cpyPhoto;
@property (nonatomic, retain) NSNumber * environmentStar;
@property (nonatomic, retain) NSNumber * evaluationStar;
@property (nonatomic, retain) NSString * glazing;
@property (nonatomic, retain) NSNumber * glazing_OriginalPrice;
@property (nonatomic, retain) NSNumber * glazing_PromotionPrice;
@property (nonatomic, retain) NSNumber * km;
@property (nonatomic, retain) NSNumber * largeSUV_OriginalPrice;
@property (nonatomic, retain) NSNumber * largeSUV_PromotionPrice;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * salesVolume;
@property (nonatomic, retain) NSNumber * smallSUV_OriginalPrice;
@property (nonatomic, retain) NSNumber * smallSUV_PromotionPrice;
@property (nonatomic, retain) NSNumber * technologyStar;
@property (nonatomic, retain) NSString * telePhone;
@property (nonatomic, retain) NSString * userEvaluation;
@property (nonatomic, retain) NSSet *beautydata;
@property (nonatomic, retain) NSSet *typeData;
@end

@interface CompanyInfo (CoreDataGeneratedAccessors)

- (void)addBeautydataObject:(CarBeautyData *)value;
- (void)removeBeautydataObject:(CarBeautyData *)value;
- (void)addBeautydata:(NSSet *)values;
- (void)removeBeautydata:(NSSet *)values;

- (void)addTypeDataObject:(CarTypeData *)value;
- (void)removeTypeDataObject:(CarTypeData *)value;
- (void)addTypeData:(NSSet *)values;
- (void)removeTypeData:(NSSet *)values;

@end
