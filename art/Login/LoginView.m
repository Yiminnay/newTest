//
//  LoginView.m
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "LoginView.h"
#import "MBProgressHUD.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //配置登陆界面
        [self configureView];
        
    }
    return self;
}

- (void)configureView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:bgView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, 140)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    whiteView.clipsToBounds = YES;
    [bgView addSubview:whiteView];
    
    
    NSArray *imgArr = @[@"gister_buttom_role",@"gister_buttom_people"];
    CGFloat imageW=18;
    CGFloat imageH=18;
    NSArray *placeHolder = @[@"请输入手机号",@"请输入登陆密码"];
    
    CGFloat textFieldW=200;
    CGFloat textFieldH=70;
    //内容
    CGFloat textFieldX=52;
    
    _phoneNum = [[UITextField alloc] init];
    _phoneNum.frame = CGRectMake(textFieldX, 0, textFieldW, textFieldH);
    _phoneNum.placeholder = placeHolder[0];
    [whiteView addSubview:_phoneNum];
    
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(textFieldX, 70, textFieldW, textFieldH);
    _password.placeholder = placeHolder[1];
    [whiteView addSubview:_password];


    
    for (int i =0; i<imgArr.count; i++) {
        //图
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX=18;
        CGFloat imageY=26+i*70;
        imageView.frame =CGRectMake(imageX, imageY, imageW, imageH);
        imageView.image = [UIImage imageNamed:imgArr[i]];
        imageView.userInteractionEnabled = YES;
        [whiteView addSubview:imageView];
        
                //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*(i+1), bgView.bounds.size.width, 1)];
        lineView.backgroundColor = Color(238, 238, 238, 1);
        [whiteView addSubview:lineView];
        
    }
    
    

    UIButton *sigUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sigUpButton.frame = CGRectMake(0, 250-55, bgView.bounds.size.width,46);
    [sigUpButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    sigUpButton.tag = 1;
    sigUpButton.layer.cornerRadius = 5;
    sigUpButton.clipsToBounds = YES;
    [sigUpButton setTitle:@"登 陆" forState:UIControlStateNormal];
    sigUpButton.backgroundColor = Color(244, 73, 51, 1);
    [bgView addSubview:sigUpButton];
    
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(bgView.bounds.size.width-100, 250-40-60, 100, 30);
    [forgetButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.tag = 2;
    [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [bgView addSubview:forgetButton];
    
}

- (void)loginButtonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(LoginView:didClick:)]) {
        [self.delegate LoginView:self didClick:sender];
    } else {
        [self.viewController showHint:@"请稍后再试" yOffset:-200];
    }

}

////登陆
//- (void)sigUpButtonAction{
//    
//}
//
////忘记密码
//- (void)forgetButtonAction{
//
//
//}



@end
