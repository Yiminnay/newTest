//
//  StuHomeViewController.m
//  art
//
//  Created by Apple on 16/1/14.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "StuHomeController.h"

@implementation StuHomeController


- (void)viewDidLoad{
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    self.title = @"首页";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    }

@end
