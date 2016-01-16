//
//  BaseViewController.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    
    self.navigationController.navigationBar.tintColor = bgColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //设置导航栏标题
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shouye"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];

}

- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
