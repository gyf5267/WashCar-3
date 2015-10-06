//
//  WCTabBarController.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCTabBarController.h"

@interface WCTabBarController ()
{
    NSInteger currentSelected;
}

@end

@implementation WCTabBarController

#define TabBar_Tag  2000


- (void)viewDidLoad {
    [super viewDidLoad];
    currentSelected = -1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTabBarItems];
}

- (void)initTabBarItems{
    
    NSUInteger viewCtrlCount = [self.viewControllers count];
    
    if (self.btnArrays) {
        self.btnArrays = nil;
    }
    
    self.btnArrays = [NSMutableArray arrayWithCapacity:viewCtrlCount];
    
    double width = [UIScreen mainScreen].bounds.size.width/viewCtrlCount;
    double heigth = self.tabBar.frame.size.height;
    
    for (int index=0; index<viewCtrlCount; index++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(index*width, 0, width, heigth);
        [btn addTarget:self action:@selector(tabBarClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString* imageName = [NSString stringWithFormat:@"icon_0%d.png",index+1];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        btn.tag = TabBar_Tag + index;
        [self.btnArrays addObject:btn];
        [self.tabBar addSubview:btn];
        
    }
    
    [self tabBarClicked:[self.btnArrays objectAtIndex:0]];
    
}

- (void)tabBarClicked:(id) pSender{
    if ([pSender isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton*)pSender;
        if (btn) {
            NSInteger tab = btn.tag;
            if (currentSelected == tab - TabBar_Tag) {
                return;
            }else{
                if (currentSelected != -1) {
                    NSString* imageName = [NSString stringWithFormat:@"icon_0%ld.png",currentSelected+1];
                    UIButton* button = [self.btnArrays objectAtIndex:currentSelected];
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                }
                
                currentSelected = tab - TabBar_Tag;
                [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_0%ldC.png", tab-TabBar_Tag+1]] forState:UIControlStateNormal];
                self.selectedIndex = currentSelected;
            }
            
        }
    }
}

-(void)setTabBarState:(BOOL)aHide{
    self.tabBar.hidden = aHide;
    
    if (aHide) {
        [self.tabBar removeFromSuperview];
    }else{
        [self.view addSubview:self.tabBar];
    }
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
