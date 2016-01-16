//
//  RegisterViewController.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController ()<RegisterViewDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    
    [self configureRegisterView];
 

}



- (void)configureRegisterView{
    RegisterView *registerView = [[RegisterView alloc] initWithFrame:CGRectMake(12, SCREEN_HEIGHT*0.2, SCREEN_WIDTH-24, SCREEN_HEIGHT*0.7)];
    registerView.delegete = self;
    [self.view addSubview:registerView];
    
    //返回
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame= CGRectMake(18, SCREEN_HEIGHT-80, 10.5,18);
    [backButton setImage:[UIImage imageNamed:@"register_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}


- (void)RegisterView:(RegisterView *)registerView didClick:(UIButton *)sender{
    if (sender.tag == 1) {//记住密码
        sender.selected = !sender.selected;
    }
    else
    {
        
    }
}
//返回
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark -- 触摸编辑区外关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
