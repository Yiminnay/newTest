//
//  AppDelegate.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "AppDelegate.h"
#import "AdvertisementViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//禁止横屏
- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
   
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置主窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    
    NSUserDefaults *userDefoults = [NSUserDefaults standardUserDefaults];
    BOOL hasLaunched = [userDefoults valueForKey:@"启动过了"];
    
    if (hasLaunched == YES) {
        //UITabBarController根视图控制器，控制五个UINavigationController
        LoginViewController *logInVC = [[LoginViewController alloc]init];
        UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:logInVC];
        self.window.rootViewController = navigationC;
    }else{
        
        self.window.rootViewController = [[AdvertisementViewController alloc]init];
        hasLaunched = NO;
    }
    
    
    [userDefoults setBool:YES forKey:@"启动过了"];
    
    //「游戏存档按钮」
    [userDefoults synchronize];
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark --进入登录界面
- (void)goLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = navigationC;
}


#pragma mark -- 进入主界面
- (void)goMain {

    self.window.rootViewController = [[MainViewController alloc] init];
}


@end
