//
//  ForgetPassController.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "ForgetPassController.h"
#import "ForgetPassView.h"
#import "RegisterView.h"


@interface ForgetPassController ()<ForgetPassViewDelegate>

@end

@implementation ForgetPassController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    
    ForgetPassView *forgetPassView = [[ForgetPassView alloc] initWithFrame:CGRectMake(12, SCREEN_HEIGHT*0.2, SCREEN_WIDTH-24, SCREEN_HEIGHT *0.6)];
    forgetPassView.delegete = self;
    [self.view addSubview:forgetPassView];


   
}


- (void)ForgetPassView:(ForgetPassView *)forgetPassView didClick:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 触摸编辑区外关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
