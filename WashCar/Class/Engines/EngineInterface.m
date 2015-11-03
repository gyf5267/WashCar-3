//
//  EngineInterface.m
//  WashCar
//
//  Created by nate on 15/8/14.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "EngineInterface.h"
#import "WCUserDefaults.h"
#import "WCNotification.h"
#import "WashCarCompanyInfo.h"
#import "CDManager+Helper.h"
#import "UtilityClass.h"
#import "CarTypeDataInfo.h"
#import "BeautyData.h"
#import "GoodsData.h"

@interface EngineInterface (){
    NSMutableArray* infoArray;
    NSMutableArray* goodsInfo;
}

@end

@implementation EngineInterface

static EngineInterface* instance = nil;

#if 0
+(id)shareInstance{
    
    @synchronized(self){
        if(instance == nil){
            instance = [[EngineInterface alloc] init];
        }
    }
    return instance;
}
#else
+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EngineInterface alloc] init];
        
        instance.currectQueue = dispatch_queue_create("MyQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return instance;
}
#endif



-(id)init{
    self = [super init];
    
    if (self) {
        infoArray = [NSMutableArray array];
        goodsInfo = [NSMutableArray array];
    }
    return self;
}


-(void)addTestData{
    //测试数据添加
    dispatch_barrier_async(self.currectQueue, ^{
        [self addDataToDB];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:Add_Cpy_Info_Notification object:nil];
        });
    });
    
    dispatch_barrier_async(self.currectQueue, ^{
        [self addgoodsDataToDB];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:Add_Goods_Info_Notification object:nil];
        });
    });
}
//这个接口当时为学生测试搞得，很垃圾啊~~
-(NSArray*)fetchCpyInfo:(NSString*)cpyName{
    
    if (cpyName == nil && infoArray.count == 0) {
        
        __block NSError* err = nil;
        __block NSArray* arrayLists = nil;
        
        
        dispatch_sync(self.currectQueue, ^{
           arrayLists  = [[CDManager shareInstance] findAllObjectData:&err];
        });
        
        if (err == nil && arrayLists && arrayLists.count > 0) {
            for (WashCarCompanyInfo* info in arrayLists) {
                [infoArray addObject:info];
            }
            return infoArray;
        }else{
            return nil;
        }
    }else{
        return infoArray;
    }
    
}

-(NSArray*)fetchCpyInfo1:(NSString*)cpyName{
    
    if (cpyName && cpyName.length>0) {
        NSError* err = nil;
        NSArray* arrayLists = [[CDManager shareInstance] findObjectWithCpyName:cpyName errCode:&err];
        if (err == nil && arrayLists && arrayLists.count > 0) {
            for (WashCarCompanyInfo* info in arrayLists) {
                [infoArray addObject:info];
            }
            return infoArray;
        }else{
            return nil;
        }
        
    }else{
        return nil;
    }
}


-(WashCarCompanyInfo*)fetchCpyInfoWithIndex:(NSString*)cpyName{
    
    for (WashCarCompanyInfo* object in infoArray) {
        if ([object.cpyName isEqualToString:cpyName]) {
            return object;
        }
    }
    
    return nil;
}

//获得商品信息的接口
-(NSArray*)fetchGoodsInfo{
    if (goodsInfo && goodsInfo.count == 0) {
        NSArray* items = [[CDManager shareInstance] fetchGoodsFromDB];
        
        if (items && items.count >0) {
            for (GoodsData* data in items) {
                [goodsInfo addObject:data];
            }
            return goodsInfo;
        }else{
            return nil;
        }
    }
    
    return goodsInfo;
}

-(NSString*)getVersionNum{
    return [WCUserDefaults getVersionNum];
}

-(void)setVersionNum:(NSString*)version{
    [WCUserDefaults setVersionNum:version];
}


-(float)getCacheDirectorySize{
    return 5.0;
}
-(void)removeCacheDirectory{
    ////////
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Remove_Cache_Directory_Size_Notification object:nil];
}


#pragma mark - 以下的方法是测试用得
-(void)addgoodsDataToDB{
    NSMutableArray* lists = [NSMutableArray array];
    
    GoodsData *goods1 = [[GoodsData alloc] init];
    goods1.frugal = @"已省5元";
    goods1.image = @"jiaodian.png";
    goods1.pay = @"12340人付款";
    goods1.postLab = @"包邮  石家庄";
    goods1.price = @"￥298.00";
    goods1.shopName = @"新福克斯卡罗拉雅阁奇骏朗逸速腾迈腾途观帕萨特Q5全包围汽车脚垫";
    
    [lists addObject:goods1];
    
    GoodsData *goods2 = [[GoodsData alloc] init];
    goods2.frugal = @"已省2元";
    goods2.image = @"qichedian.png";
    goods2.pay = @"10186人付款";
    goods2.postLab = @"包邮  邢台";
    goods2.price = @"￥188.00";
    goods2.shopName = @"全包围丝圈汽车脚垫专车专用新福克斯迈腾轩逸奇骏速腾朗逸车型全";
    
    [lists addObject:goods2];
    
    GoodsData *goods3 = [[GoodsData alloc] init];
    goods3.frugal = @"已省3元";
    goods3.image = @"qichekaobei.png";
    goods3.pay = @"35人付款";
    goods3.postLab = @"包邮  台州";
    goods3.price = @"￥398.00";
    goods3.shopName = @"四季通用全包汽车坐垫昕锐轩逸阳光凯越宝来英朗冰丝亚麻座垫座套";
    [lists addObject:goods3];
    
    for (id object in lists) {
        [[CDManager shareInstance] addObjectData:object];
    }
    
}

//测试数据
-(void)addDataToDB{
    WashCarCompanyInfo * comm1 = [[WashCarCompanyInfo alloc] init];
    comm1.cpyName=@"米其林驰加胜利路店";
    comm1.cpyAddress=@"大连市西岗区胜利路113号";
    comm1.telePhone = @"10086";
    //    comm1.evaluationStar=@"✨✨✨ 3分";
    comm1.evaluationStar = [NSNumber numberWithInteger:3];
    comm1.km= [NSNumber numberWithFloat:2.5]; //@"2.5KM";
    comm1.cpyPhoto=@"20.jpg";
    comm1.latitude=[NSNumber numberWithInteger:120];
    comm1.longitude=[NSNumber numberWithInteger:38];
    
    comm1.salesVolume = [NSNumber numberWithInteger:32];
    
    CarTypeDataInfo* carType = [[CarTypeDataInfo alloc] init];
    carType.type = [NSNumber numberWithInteger:carType_car];
    carType.originalPrice = [NSNumber numberWithInteger:40.0];
    carType.discountPrice = [NSNumber numberWithInteger:30.0];
    
    CarTypeDataInfo* carType1 = [[CarTypeDataInfo alloc] init];
    carType1.type = [NSNumber numberWithInteger:carType_Small_SUV];
    carType1.originalPrice = [NSNumber numberWithInteger:40.0];
    carType1.discountPrice = [NSNumber numberWithInteger:60.0];
    
    CarTypeDataInfo* carType2 = [[CarTypeDataInfo alloc] init];
    carType2.type = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    carType2.originalPrice = [NSNumber numberWithInteger:50.0];
    carType2.discountPrice = [NSNumber numberWithInteger:70.0];
    
    NSMutableSet* typeData = [NSMutableSet set];
    [typeData addObject:carType];
    [typeData addObject:carType1];
    [typeData addObject:carType2];
    
    comm1.typeData = typeData;
    
    BeautyData* beautyType = [[BeautyData alloc] init];
    beautyType.type = [NSNumber numberWithInteger:beautyType_armor];
    beautyType.originalPrice = [NSNumber numberWithInteger:500.0];
    beautyType.discountPrice = [NSNumber numberWithInteger:300.0];
    
    BeautyData* beautyType1 = [[BeautyData alloc] init];
    beautyType1.type = [NSNumber numberWithInteger:beautyType_coating];
    beautyType1.originalPrice = [NSNumber numberWithInteger:1000.0];
    beautyType1.discountPrice = [NSNumber numberWithInteger:800.0];
    
    BeautyData* beautyType2 = [[BeautyData alloc] init];
    beautyType2.type = [NSNumber numberWithInteger:beautyType_glazing];
    beautyType2.originalPrice = [NSNumber numberWithInteger:1500.0];
    beautyType2.discountPrice = [NSNumber numberWithInteger:1200.0];
    
    NSMutableSet* beautyData = [NSMutableSet set];
    [beautyData addObject:beautyType];
    [beautyData addObject:beautyType1];
    [beautyData addObject:beautyType2];
    
    comm1.beautydata = beautyData;
    
    comm1.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm1.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm1.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm1.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm1.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm1.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm1.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm1.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm1.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm1.attitudeStar = [NSNumber numberWithInteger:3];
    comm1.technologyStar = [NSNumber numberWithInteger:3];
    comm1.environmentStar = [NSNumber numberWithInteger:3];
    
    comm1.armor = @"地盘装甲";
    comm1.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm1.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm1.coating = @"镀膜";
    comm1.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm1.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm1.glazing = @"封釉";
    comm1.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm1.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm1.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    
    
    WashCarCompanyInfo * comm2 = [[WashCarCompanyInfo alloc]init];
    comm2.cpyName=@"金龙驰汽车服务中心";
    comm2.cpyAddress=@"沙河口区玉华街13号";
    comm2.telePhone = @"15524557800";
    
    comm2.evaluationStar = [NSNumber numberWithInteger:5];
    //    comm2.star=@"✨✨✨✨✨ 5分";
    comm2.km= [NSNumber numberWithFloat:3.1];//@"1.1KM";
    comm2.cpyPhoto=@"14.jpg";
    comm2.latitude=[NSNumber numberWithInteger:120];
    comm2.longitude=[NSNumber numberWithInteger:38];
    
    comm2.salesVolume = [NSNumber numberWithInteger:32];
    comm2.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm2.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm2.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm2.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm2.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm2.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm2.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm2.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm2.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm2.attitudeStar = [NSNumber numberWithInteger:3];
    comm2.technologyStar = [NSNumber numberWithInteger:3];
    comm2.environmentStar = [NSNumber numberWithInteger:3];
    
    comm2.armor = @"地盘装甲";
    comm2.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm2.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm2.coating = @"镀膜";
    comm2.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm2.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm2.glazing = @"封釉";
    comm2.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm2.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm2.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    
    comm2.typeData = typeData;
    comm2.beautydata = beautyData;
    
    WashCarCompanyInfo * comm3 = [[WashCarCompanyInfo alloc]init];
    comm3.cpyName=@"兴圣汽车美容护养中心";
    comm3.cpyAddress=@"西岗区长春路";
    comm3.telePhone = @"15524557800";
    
    comm3.evaluationStar = [NSNumber numberWithInteger:3];//star=@"✨✨✨ 3分";
    comm3.km=[NSNumber numberWithFloat:11.5];//@"3.5KM";
    comm3.cpyPhoto=@"103.jpg";
    comm3.latitude=[NSNumber numberWithInteger:120];
    comm3.longitude=[NSNumber numberWithInteger:38];
    
    comm3.salesVolume = [NSNumber numberWithInteger:32];
    comm3.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm3.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm3.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm3.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm3.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm3.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm3.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm3.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm3.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm3.attitudeStar = [NSNumber numberWithInteger:3];
    comm3.technologyStar = [NSNumber numberWithInteger:3];
    comm3.environmentStar = [NSNumber numberWithInteger:3];
    
    comm3.armor = @"地盘装甲";
    comm3.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm3.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm3.coating = @"镀膜";
    comm3.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm3.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm3.glazing = @"封釉";
    comm3.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm3.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm3.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm3.typeData = typeData;
    comm3.beautydata = beautyData;
    
    WashCarCompanyInfo * comm4 = [[WashCarCompanyInfo alloc]init];
    comm4.cpyName=@"东博汽车美容";
    comm4.cpyAddress=@"沙河口区";
    comm4.telePhone = @"15524557800";
    
    comm4.evaluationStar = [NSNumber numberWithInteger:3];//star=@"✨✨✨ 3分";
    comm4.km=[NSNumber numberWithFloat:8.7];//@"1.5KM";
    comm4.cpyPhoto=@"22.jpg";
    comm4.latitude=[NSNumber numberWithInteger:120];
    comm4.longitude=[NSNumber numberWithInteger:38];
    
    comm4.salesVolume = [NSNumber numberWithInteger:32];
    comm4.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm4.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm4.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm4.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm4.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm4.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm4.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm4.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm4.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm4.attitudeStar = [NSNumber numberWithInteger:3];
    comm4.technologyStar = [NSNumber numberWithInteger:3];
    comm4.environmentStar = [NSNumber numberWithInteger:3];
    
    comm4.armor = @"地盘装甲";
    comm4.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm4.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm4.coating = @"镀膜";
    comm4.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm4.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm4.glazing = @"封釉";
    comm4.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm4.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm4.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm4.typeData = typeData;
    comm4.beautydata = beautyData;
    
    WashCarCompanyInfo * comm5 = [[WashCarCompanyInfo alloc]init];
    comm5.cpyName=@"洗车の王国嘉鹏店";
    comm5.cpyAddress=@"甘井子区";
    comm5.telePhone = @"15524557800";
    
    comm5.evaluationStar = [NSNumber numberWithInteger:2];//star=@"✨✨ 2分";
    comm5.km=[NSNumber numberWithFloat:24.7];//@"8.4KM";
    comm5.cpyPhoto=@"105.jpg";
    comm5.latitude=[NSNumber numberWithInteger:120];
    comm5.longitude=[NSNumber numberWithInteger:38];
    
    comm5.salesVolume = [NSNumber numberWithInteger:32];
    comm5.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm5.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm5.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm5.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm5.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm5.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm5.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm5.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm5.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm5.attitudeStar = [NSNumber numberWithInteger:3];
    comm5.technologyStar = [NSNumber numberWithInteger:3];
    comm5.environmentStar = [NSNumber numberWithInteger:3];
    
    comm5.armor = @"地盘装甲";
    comm5.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm5.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm5.coating = @"镀膜";
    comm5.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm5.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm5.glazing = @"封釉";
    comm5.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm5.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm5.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm5.typeData = typeData;
    comm5.beautydata = beautyData;
    
    WashCarCompanyInfo * comm6 = [[WashCarCompanyInfo alloc]init];
    comm6.cpyName=@"天卓汽车美容中心";
    comm6.cpyAddress=@"甘井子区";
    comm6.evaluationStar = [NSNumber numberWithInteger:5];//star=@"✨✨✨✨✨ 5分";
    comm6.km=[NSNumber numberWithFloat:7.8];//@"9.5KM";
    comm6.cpyPhoto=@"106.jpg";
    comm6.latitude=[NSNumber numberWithInteger:120];
    comm6.longitude=[NSNumber numberWithInteger:38];
    comm6.telePhone = @"15524557800";
    
    comm6.salesVolume = [NSNumber numberWithInteger:32];
    comm6.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm6.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm6.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm6.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm6.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm6.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm6.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm6.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm6.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm6.attitudeStar = [NSNumber numberWithInteger:3];
    comm6.technologyStar = [NSNumber numberWithInteger:3];
    comm6.environmentStar = [NSNumber numberWithInteger:3];
    
    comm6.armor = @"地盘装甲";
    comm6.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm6.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm6.coating = @"镀膜";
    comm6.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm6.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm6.glazing = @"封釉";
    comm6.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm6.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm6.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm6.typeData = typeData;
    comm6.beautydata = beautyData;
    
    
    WashCarCompanyInfo * comm7 = [[WashCarCompanyInfo alloc]init];
    comm7.cpyName=@"车之光";
    comm7.cpyAddress=@"中山区昆明街41号";
    comm7.telePhone = @"15524557800";
    
    comm7.evaluationStar = [NSNumber numberWithInteger:4];//star=@"✨✨✨✨ 4分";
    comm7.km=[NSNumber numberWithFloat:2.1];//@"12.5KM";
    comm7.cpyPhoto=@"107.jpg";
    comm7.latitude=[NSNumber numberWithInteger:120];
    comm7.longitude=[NSNumber numberWithInteger:38];
    
    comm7.salesVolume = [NSNumber numberWithInteger:32];
    comm7.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm7.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm7.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm7.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm7.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm7.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm7.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm7.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm7.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm7.attitudeStar = [NSNumber numberWithInteger:3];
    comm7.technologyStar = [NSNumber numberWithInteger:3];
    comm7.environmentStar = [NSNumber numberWithInteger:3];
    
    comm7.armor = @"地盘装甲";
    comm7.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm7.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm7.coating = @"镀膜";
    comm7.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm7.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm7.glazing = @"封釉";
    comm7.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm7.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm7.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm7.typeData = typeData;
    comm7.beautydata = beautyData;
    
    WashCarCompanyInfo * comm8 = [[WashCarCompanyInfo alloc]init];
    comm8.cpyName=@"尊锐汽车";
    comm8.cpyAddress=@"中山区望海街29号";
    comm8.telePhone = @"15524557800";
    
    comm8.evaluationStar = [NSNumber numberWithInteger:3];//star=@"✨✨✨ 3分";
    comm8.km=[NSNumber numberWithFloat:3.5];//@"11.8KM";
    comm8.cpyPhoto=@"108.jpg";
    comm8.latitude=[NSNumber numberWithInteger:120];
    comm8.longitude=[NSNumber numberWithInteger:38];
    
    comm8.salesVolume = [NSNumber numberWithInteger:32];
    comm8.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm8.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm8.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm8.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm8.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm8.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm8.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm8.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm8.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm8.attitudeStar = [NSNumber numberWithInteger:3];
    comm8.technologyStar = [NSNumber numberWithInteger:3];
    comm8.environmentStar = [NSNumber numberWithInteger:3];
    
    comm8.armor = @"地盘装甲";
    comm8.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm8.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm8.coating = @"镀膜";
    comm8.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm8.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm8.glazing = @"封釉";
    comm8.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm8.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm8.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm8.typeData = typeData;
    comm8.beautydata = beautyData;
    
    WashCarCompanyInfo * comm9 = [[WashCarCompanyInfo alloc]init];
    comm9.cpyName=@"JK汽车俱乐部";
    comm9.cpyAddress=@"西岗区";
    comm9.telePhone = @"15524557800";
    
    comm9.evaluationStar = [NSNumber numberWithInteger:5];//star=@"✨✨✨✨✨ 5分";
    comm9.km=[NSNumber numberWithFloat:7.6];//@"3.4KM";
    comm9.cpyPhoto=@"109.jpg";
    comm9.latitude=[NSNumber numberWithInteger:120];
    comm9.longitude=[NSNumber numberWithInteger:38];
    
    comm9.salesVolume = [NSNumber numberWithInteger:32];
    comm9.carType_Car = [NSNumber numberWithInteger:carType_car];
    comm9.car_OriginalPrice = [NSNumber numberWithInteger:30.0];
    comm9.car_PromotionPrice = [NSNumber numberWithInteger:40.0];
    
    comm9.carType_SmallSUV = [NSNumber numberWithInteger:carType_Small_SUV];
    comm9.smallSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm9.smallSUV_PromotionPrice = [NSNumber numberWithInteger:50];
    
    comm9.carType_LargeSUV = [NSNumber numberWithInteger:carType_Large_medium_SUV];
    comm9.largeSUV_OriginalPrice = [NSNumber numberWithInteger:40];
    comm9.largeSUV_PromotionPrice = [NSNumber numberWithInteger:60];
    
    comm9.attitudeStar = [NSNumber numberWithInteger:3];
    comm9.technologyStar = [NSNumber numberWithInteger:3];
    comm9.environmentStar = [NSNumber numberWithInteger:3];
    
    comm9.armor = @"地盘装甲";
    comm9.armor_OriginalPrice = [NSNumber numberWithInteger:400.00];
    comm9.armor_PromotionPrice = [NSNumber numberWithInteger:600.00];
    
    comm9.coating = @"镀膜";
    comm9.coating_OriginalPrice = [NSNumber numberWithInteger:900.00];
    comm9.coating_PromotionPrice = [NSNumber numberWithInteger:1200.00];
    
    comm9.glazing = @"封釉";
    comm9.glazing_OriginalPrice = [NSNumber numberWithInteger:300.00];
    comm9.glazing_PromotionPrice = [NSNumber numberWithInteger:450.00];
    
    comm9.userEvaluation = @"常年洗车，态度很好~~，环境优雅!!";
    comm9.typeData = typeData;
    comm9.beautydata = beautyData;
    
    NSMutableArray* arrayList = [[NSMutableArray alloc] init];
    [arrayList addObject:comm1];
    [arrayList addObject:comm2];
    [arrayList addObject:comm3];
    [arrayList addObject:comm4];
    [arrayList addObject:comm5];
    [arrayList addObject:comm6];
    [arrayList addObject:comm7];
    [arrayList addObject:comm8];
    [arrayList addObject:comm9];
    
    for (id object in arrayList) {
        [[CDManager shareInstance] addObjectData:object];
    }
    
}

-(BOOL)removeCpyInfoWithCpyName:(NSString*)cpyName{
    
    if (cpyName && cpyName.length>0) {
        
        BOOL succ = [[CDManager shareInstance] removeCpyInfo:cpyName];
        if (succ) {
            
            for (id object in infoArray) {
                WashCarCompanyInfo* info = (WashCarCompanyInfo*)object;
                
                if ([info.cpyName isEqualToString:cpyName]) {
                    [infoArray removeObject:info];
                    break;
                }
            }
            return YES;
        }else{
            return NO;
        }
        
    }
    return NO;
}

//通知接口
-(void)add_Notifaction{
    [[NSNotificationCenter defaultCenter] postNotificationName:Add_Notification object:nil];
}








@end
