//
//  AppDelegate.m
//  WashCar
//
//  Created by 高 玉锋 on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "AppDelegate.h"
#import "WashViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"
#import "WCNavigationController.h"
#import "WCTabBarController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "EngineInterface.h"
#import "WCNewFunctionIntroduction.h"
#import "WCUserDefaults.h"
#import "ShopViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString* homePath = NSHomeDirectory();
    NSLog(@"homePath=%@", homePath);
    
    NSLog(@"app=%@",[NSBundle mainBundle].bundlePath);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];

    [self initControllers];
    
    if (![WCUserDefaults isFirstRun]) {
//        [WCUserDefaults setFirstRun:YES];
        [WCNewFunctionIntroduction showView];
    }
    [[EngineInterface shareInstance] addTestData];
    [[EngineInterface shareInstance] setVersionNum:@"2.0"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self beingBackgroundUpdateTask];
    
    // 在这里加上你需要长久运行的代码
    
    [self endBackgroundUpdateTask];
}

- (void)beingBackgroundUpdateTask{
    
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
        [self endBackgroundUpdateTask];
        
    }];
    
}

- (void)endBackgroundUpdateTask{
    
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

-(void)initControllers{
    WashViewController* washCtl = [[WashViewController alloc] init];
    WCNavigationController* washNav = [[WCNavigationController alloc] initWithRootViewController:washCtl];
    
    ShopViewController* shopCtl = [[ShopViewController alloc] init];
    WCNavigationController* shopNav = [[WCNavigationController alloc] initWithRootViewController:shopCtl];
    
    FindViewController* findCtl = [[FindViewController alloc] init];
    WCNavigationController* findNav = [[WCNavigationController alloc] initWithRootViewController:findCtl];
    
    MineViewController* mineCtl = [[MineViewController alloc] init];
    WCNavigationController* mineNav = [[WCNavigationController alloc] initWithRootViewController:mineCtl];
    
    NSArray* viewControllers = [NSArray arrayWithObjects:washNav, shopNav, findNav,mineNav,nil];
    
    WCTabBarController* tabBar = [[WCTabBarController alloc] init];
    tabBar.viewControllers = viewControllers;
    
    self.window.rootViewController = tabBar;
    
}

#pragma mark -TecentOauth
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

@end
