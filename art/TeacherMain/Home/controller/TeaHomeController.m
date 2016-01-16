//
//  TeaHomeController.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "TeaHomeController.h"

@interface TeaHomeController ()

@end

@implementation TeaHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    self.title = @"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}


- (void)leftBarButtonItem{
    [self popoverPresentationController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
