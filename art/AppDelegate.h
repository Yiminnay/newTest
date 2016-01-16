//
//  AppDelegate.h
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic)NSInteger isTeacher;

@property (assign, nonatomic)NSInteger isStudent;

- (void)goLoginViewController;

- (void)goMain;

@end

