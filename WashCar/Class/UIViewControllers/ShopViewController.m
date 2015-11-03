//
//  ShopViewController.m
//  WashCar
//
//  Created by nate on 15/8/27.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "ShopViewController.h"
#import "UIColorDef.h"
#import "WCBaseViewController+Navigation.h"
#import "EngineInterface.h"
#import "WCNotification.h"


@interface ShopViewController ()

@end

@implementation ShopViewController

-(id)init{
    self = [super init];
    
    if (self) {
        self.style = UITableViewStylePlain;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self initDataSource];
}



-(void)initDataSource{
    [[EngineInterface  shareInstance] fetchGoodsInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavBar];
}

-(void)initNavBar{
    UIView* navBg = [[UIView alloc] init];
    navBg.backgroundColor = UIColorFromRGB(COLOR_NAVIGATION_BAR_BACKGROUND);
    
    [self setNavBarTitle:@"店铺" andBgView:navBg titleFrame:CGRectMake(110, 32, 100, 22)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString* cellName = @"cellName";
    //首先根据标识去缓存池取
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    //如果缓存池没有到则重新创建并放到缓存池中
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.text = @"张三";
    
    return cell;
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
