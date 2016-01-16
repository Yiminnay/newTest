//
//  LoginView.h
//  art
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;
@protocol LoginViewDelegate <NSObject>

- (void)LoginView:(LoginView *)loginView didClick:(UIButton *)sender;

@end

@interface LoginView : UIView

@property(nonatomic,weak) id<LoginViewDelegate> delegate;
//手机号
@property(nonatomic,strong)UITextField *phoneNum;
//密码
@property(nonatomic,strong)UITextField *password;



@end
