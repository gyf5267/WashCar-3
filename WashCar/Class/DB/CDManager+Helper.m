//
//  CDManager+Helper.m
//  CoreDataDemo
//
//  Created by nate on 15/7/10.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "CDManager+Helper.h"

#import "CompanyInfo.h"
#import "WashCarCompanyInfo.h"

#import "CarTypeDataInfo.h"
#import "CarTypeData.h"

#import "BeautyData.h"
#import "CarBeautyData.h"

#import "GoodsData.h"
#import "Goods.h"

@implementation CDManager (Helper)

-(BOOL)addObjectData:(id)data{
    BOOL succ = NO;
    
    if (data && [data isKindOfClass:[WashCarCompanyInfo class]]) {
        succ = [self companyInfoToDB:data];
    }else if(data && [data isKindOfClass:[GoodsData class]]){
        succ = [self goodsToDB:data];
    }else{
        return NO;
    }
    
    if (succ) {
        [self saveContext];
        return YES;
    }
    return NO;
}

-(BOOL)goodsToDB:(id)data{
    GoodsData* goods = (GoodsData*)data;
    
    NSError* err = nil;
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"Goods" ];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"shopName=%@",goods.shopName];
    
    [fetch setPredicate:predicate];
    
    NSArray* items = [self.managedObjectContext executeFetchRequest:fetch error:&err];
    
    if (items && items.count ==0 && err == nil) {
        Goods* gds = [NSEntityDescription insertNewObjectForEntityForName:@"Goods" inManagedObjectContext:self.managedObjectContext];
        
        gds.shopName = goods.shopName;
        gds.frugal = goods.frugal;
        gds.image = goods.image;
        gds.pay = goods.pay;
        gds.postLab = goods.postLab;
        gds.price = goods.price;
        return YES;
    }
    return NO;
}

//返回店铺信息
-(NSArray*)fetchGoodsFromDB{
    NSError* err = nil;
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"Goods" ];
    
    NSArray* items = [self.managedObjectContext executeFetchRequest:fetch error:&err];
    
    if (items && items.count >0 && err == nil) {
        NSMutableArray* dataArray = [NSMutableArray array];
        
        for (Goods* gds in items) {
            GoodsData* data = [[GoodsData alloc] init];
            
            data.shopName = gds.shopName;
            data.frugal = gds.frugal;
            data.image = gds.image;
            data.pay = gds.pay;
            data.postLab = gds.postLab;
            data.price = gds.price;
            
            [dataArray addObject:data];
        }
        return dataArray;
    }
    
    return nil;
}

-(BOOL)companyInfoToDB:(id)data{
    WashCarCompanyInfo* wcInfo = (WashCarCompanyInfo*)data;
    NSError* err = nil;
    
    NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cpyName=%@", wcInfo.cpyName];
    
    [req setPredicate:predicate];
    
    NSArray* items = [self.managedObjectContext executeFetchRequest:req error:&err];
    
    if (items && items.count == 0) {
        CompanyInfo* info = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyInfo" inManagedObjectContext:self.managedObjectContext];
        
        WashCarCompanyInfo* cpyInfo = (WashCarCompanyInfo*)data;
        [self wcCpyInfoToDBCpyInfo:cpyInfo ToDBData:&info];
        return YES;
    }else{
        return NO;
    }
}

//返回指定公司数据
-(NSArray*)findObjectWithCpyName:(NSString*)cpyName errCode:(NSError**)error{
    NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cpyName=%@",cpyName];
    [req setPredicate:predicate];
    
    NSError* err = nil;
    NSArray* arrayLists = [self.managedObjectContext executeFetchRequest:req error:&err];
    
    if (err == nil && arrayLists && arrayLists.count>0) {
        return [self wcCpyInfofromDBCpyInfo:arrayLists];
    }else{
        
        return nil;
    }
}

-(NSArray*)findAllObjectData:(NSError**)error{
    
    NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
    
    NSArray* itemArrays = [self.managedObjectContext executeFetchRequest:req error:error];
    
    if (*error == nil && itemArrays && itemArrays.count) {
        return [self wcCpyInfofromDBCpyInfo:itemArrays];
    }else{
        return nil;
    }
    
}

-(BOOL)removeAllObject{
    
    NSError* err = nil;
    
    NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
    
    NSArray* items = [self.managedObjectContext executeFetchRequest:req error:&err];
    
    if ((err == nil) && items && (items.count)) {
        
        for (NSManagedObject* array in items) {
            [self.managedObjectContext deleteObject:array];
        }
        
        [self saveContext];
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)modifyObjectData:(id)object{
    if (object && [object isKindOfClass:[WashCarCompanyInfo class]]) {
        WashCarCompanyInfo* data = (WashCarCompanyInfo*)object;
        NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
        req.predicate = [NSPredicate predicateWithFormat:@"cpyName=%@",data.cpyName];
        
        NSError* err = nil;
        NSArray* items = [self.managedObjectContext executeFetchRequest:req error:&err];
        
        if ((items) && ([items count]>=1) && (!err)) {
            for (NSManagedObject* object in items) {
                CompanyInfo* info = (CompanyInfo*)object;
                
                if ([data.cpyName isEqualToString:info.cpyName]) {
                    [self wcCpyInfoToDBCpyInfo:data ToDBData:&info];
                }
                
                [self saveContext];
                
            }
            return YES;
        }
        
    }
    return NO;
}

-(NSArray*)wcCpyInfofromDBCpyInfo:(NSArray*)arrayLists{
    if (arrayLists != nil && arrayLists.count > 0) {
        NSMutableArray* lists = [[NSMutableArray alloc] init];
        
        for (NSManagedObject* object in arrayLists) {
            CompanyInfo* DBinfo = (CompanyInfo*)object;
            
            WashCarCompanyInfo* cpyInfo = [[WashCarCompanyInfo alloc] init];
            cpyInfo.cpyName = DBinfo.cpyName;
            cpyInfo.cpyAddress = DBinfo.cpyAddress;
            cpyInfo.cpyPhoto = DBinfo.cpyPhoto;
            cpyInfo.km = DBinfo.km;
            cpyInfo.longitude = DBinfo.longitude;
            cpyInfo.latitude = DBinfo.latitude;
            cpyInfo.telePhone = DBinfo.telePhone;
            cpyInfo.salesVolume = DBinfo.salesVolume;
            
            cpyInfo.carType_Car = DBinfo.carType_Car;
            cpyInfo.car_OriginalPrice = DBinfo.car_OriginalPrice;
            cpyInfo.car_PromotionPrice = DBinfo.car_PromotionPrice;
            
            cpyInfo.carType_SmallSUV = DBinfo.carType_SmallSUV;
            cpyInfo.smallSUV_OriginalPrice = DBinfo.smallSUV_OriginalPrice;
            cpyInfo.smallSUV_PromotionPrice = DBinfo.smallSUV_PromotionPrice;
            
            cpyInfo.carType_LargeSUV = DBinfo.carType_LargeSUV;
            cpyInfo.largeSUV_OriginalPrice = DBinfo.largeSUV_OriginalPrice;
            cpyInfo.largeSUV_PromotionPrice = DBinfo.largeSUV_PromotionPrice;
            
            cpyInfo.attitudeStar = DBinfo.attitudeStar;
            cpyInfo.evaluationStar = DBinfo.evaluationStar;
            cpyInfo.technologyStar = DBinfo.technologyStar;
            cpyInfo.environmentStar = DBinfo.environmentStar;
            
            cpyInfo.armor = DBinfo.armor;
            cpyInfo.armor_OriginalPrice = DBinfo.armor_OriginalPrice;
            cpyInfo.armor_PromotionPrice = DBinfo.armor_PromotionPrice;
            
            cpyInfo.coating = DBinfo.coating;
            cpyInfo.coating_OriginalPrice = DBinfo.coating_OriginalPrice;
            cpyInfo.coating_PromotionPrice = DBinfo.coating_PromotionPrice;
            
            cpyInfo.glazing = DBinfo.glazing;
            cpyInfo.glazing_OriginalPrice = DBinfo.glazing_OriginalPrice;
            cpyInfo.glazing_PromotionPrice = DBinfo.glazing_PromotionPrice;
            
            cpyInfo.userEvaluation = DBinfo.userEvaluation;
            
            cpyInfo.typeData = [NSMutableSet set];
            
            for (CarTypeData* info in DBinfo.typeData) {
                CarTypeDataInfo* data = [[CarTypeDataInfo alloc] init];
                data.type = info.type;
                data.originalPrice = info.originalPrice;
                data.discountPrice = info.discountPrice;
                
                [cpyInfo.typeData addObject:data];
            }
            
            cpyInfo.beautydata = [NSMutableSet set];
            
            for (CarBeautyData* beautyInfo in DBinfo.beautydata) {
                BeautyData* data = [[BeautyData alloc] init];
                data.type = beautyInfo.type;
                data.originalPrice = beautyInfo.originalPrice;
                data.discountPrice = beautyInfo.discountPrice;
                
                [cpyInfo.beautydata addObject:data];
            }
            
            [lists addObject:cpyInfo];
        }
        return lists;
    }
    return nil;
}

-(void)wcCpyInfoToDBCpyInfo:(WashCarCompanyInfo*)WCInfo ToDBData:(CompanyInfo**)entity{
    
    if (WCInfo != nil && entity != nil) {
        (*entity).cpyName = WCInfo.cpyName;
        (*entity).cpyAddress = WCInfo.cpyAddress;
        (*entity).cpyPhoto = WCInfo.cpyPhoto;
        (*entity).km = WCInfo.km;
        (*entity).longitude = WCInfo.longitude;
        (*entity).latitude = WCInfo.latitude;
        (*entity).telePhone = WCInfo.telePhone;
        (*entity).salesVolume = WCInfo.salesVolume;
        
        (*entity).carType_Car = WCInfo.carType_Car;
        (*entity).car_OriginalPrice = WCInfo.car_OriginalPrice;
        (*entity).car_PromotionPrice = WCInfo.car_PromotionPrice;
        
        (*entity).carType_SmallSUV = WCInfo.carType_SmallSUV;
        (*entity).smallSUV_OriginalPrice = WCInfo.smallSUV_OriginalPrice;
        (*entity).smallSUV_PromotionPrice = WCInfo.smallSUV_PromotionPrice;
        
        (*entity).carType_LargeSUV = WCInfo.carType_LargeSUV;
        (*entity).largeSUV_OriginalPrice = WCInfo.largeSUV_OriginalPrice;
        (*entity).largeSUV_PromotionPrice = WCInfo.largeSUV_PromotionPrice;
        
        (*entity).attitudeStar = WCInfo.attitudeStar;
        (*entity).evaluationStar = WCInfo.evaluationStar;
        (*entity).technologyStar = WCInfo.technologyStar;
        (*entity).environmentStar = WCInfo.environmentStar;
        
        (*entity).armor = WCInfo.armor;
        (*entity).armor_OriginalPrice = WCInfo.armor_OriginalPrice;
        (*entity).armor_PromotionPrice = WCInfo.armor_PromotionPrice;
        
        (*entity).coating = WCInfo.coating;
        (*entity).coating_OriginalPrice = WCInfo.coating_OriginalPrice;
        (*entity).coating_PromotionPrice = WCInfo.coating_PromotionPrice;
        
        (*entity).glazing = WCInfo.glazing;
        (*entity).glazing_OriginalPrice = WCInfo.glazing_OriginalPrice;
        (*entity).glazing_PromotionPrice = WCInfo.glazing_PromotionPrice;
        
        (*entity).userEvaluation = WCInfo.userEvaluation;
        
        NSMutableSet* dbTypeData = [NSMutableSet set];
        
        //级联操作-
        for (CarTypeDataInfo* object  in WCInfo.typeData) {
            CarTypeData* typeData = [NSEntityDescription insertNewObjectForEntityForName:@"CarTypeData" inManagedObjectContext:self.managedObjectContext];
            
            typeData.type = object.type;
            typeData.originalPrice = object.originalPrice;
            typeData.discountPrice = object.discountPrice;
            
            [dbTypeData addObject:typeData];
        }
        
        (*entity).typeData = dbTypeData;
        
        NSMutableSet* dbBeautyData = [NSMutableSet set];
        
        for (BeautyData* object  in WCInfo.beautydata) {
            CarBeautyData* beautyData = [NSEntityDescription insertNewObjectForEntityForName:@"CarBeautyData" inManagedObjectContext:self.managedObjectContext];
            
            beautyData.type = object.type;
            beautyData.originalPrice = object.originalPrice;
            beautyData.discountPrice = object.discountPrice;
            
            [dbBeautyData addObject:beautyData];
        }
        
        (*entity).beautydata = dbBeautyData;
    }
    
}

-(BOOL)removeCpyInfo:(NSString*)cpyName{
    if (cpyName && cpyName.length>0) {
        
        NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"CompanyInfo"];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cpyName=%@", cpyName];
        
        [fetch setPredicate:predicate];
        
        NSError* err = nil;
        
        NSArray* items = [self.managedObjectContext executeFetchRequest:fetch error:&err];
        
        if (items && items.count>0 && err == nil) {
            for (CompanyInfo* info in items) {
                [self.managedObjectContext deleteObject:info];
            }
            
            [self saveContext];
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
}

@end
