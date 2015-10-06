//
//  CustomViewController.m
//  WashCar
//
//  Created by nate on 15/9/7.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "CustomViewController.h"
#import "WCBaseViewController+Navigation.h"
#import "CustomTableViewCell.h"
#import "CustomMyData.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

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
    
    self.hasNavBackButton = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setNavBarTitle:@"用户自定控件"];
    [self initDataSource];
    
    [self.tableView reloadData];
    
}

-(void)initDataSource{
    CustomMyData* data = [[CustomMyData alloc] init];
    data.imageName = @"20.jpg";
    data.nickName = @"缘分天空";
    data.sex = 1;
    
    CustomMyData* data1 = [[CustomMyData alloc] init];
    data1.imageName = @"20.jpg";
    data1.nickName = @"缘分天空";
    data1.sex = 0;
    
    CustomMyData* data2 = [[CustomMyData alloc] init];
    data2.imageName = @"20.jpg";
    data2.nickName = @"缘分天空";
    data2.sex = 1;
    
    CustomMyData* data3 = [[CustomMyData alloc] init];
    data3.imageName = @"20.jpg";
    data3.nickName = @"缘分天空";
    data3.sex = 0;
    
    self.tableViewDataArray = [NSArray arrayWithObjects:data, data1, data2,data3, nil];
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
    CustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    //如果缓存池没有到则重新创建并放到缓存池中
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (indexPath.row>=0 && indexPath.row<self.tableViewDataArray.count) {
        cell.myData = [self.tableViewDataArray objectAtIndex:indexPath.row];
    }
    
    [cell updateMyCell];
    
    return cell;
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
