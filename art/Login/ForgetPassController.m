//
//  ForgetPassController.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "ForgetPassController.h"

@interface ForgetPassController ()

@end

@implementation ForgetPassController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    
    
    UITextField *phoneNume = [[UITextField alloc] init];
    phoneNume.placeholder = @"请输入手机号";
    phoneNume.textColor = [UIColor whiteColor];
    phoneNume.frame = CGRectMake(10, 100, self.view.bounds.size.width, 70);
    [self.view addSubview:phoneNume];

    
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
