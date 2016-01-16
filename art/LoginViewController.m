//
//  LoginViewController.m
//  iYi
//
//  Created by sunyan on 15/10/10.
//  Copyright (c) 2015年 SJWL-HJT. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPassController.h"
#import "RegisterViewController.h"
#import "LoginView.h"
#import "MainViewController.h"
#import "ArtNavigationController.h"
#import "MyMD5.h"
#import "MyDataService.h"
#import "RelationController.h"


@interface LoginViewController ()<LoginViewDelegate>
@end

@implementation LoginViewController{
    LoginView *_loginView;
}


- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rigester_bg"]];
    [self configureView];
}


- (void)configureView{
    
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(25, SCREEN_HEIGHT*0.25, SCREEN_WIDTH-50, 250)];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    
    
    
    UIButton *sigInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sigInButton.frame = CGRectMake(0, SCREEN_HEIGHT-80, self.view.bounds.size.width, 30);
    [sigInButton setTitle:@"还没账号？立即注册" forState:UIControlStateNormal];
    [sigInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sigInButton addTarget:self action:@selector(sigInButtonButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sigInButton];
    
}

//注册
- (void)sigInButtonButtonAction{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


//忘记密码//登陆
- (void)LoginView:(LoginView *)loginView didClick:(UIButton *)sender{
    if (sender.tag == 1)//登陆
    {
//        MainViewController *mainVC = [[MainViewController alloc] init];
//        ArtNavigationController *artNaviVC = [[ArtNavigationController alloc] initWithRootViewController:mainVC];
//        [self presentViewController:artNaviVC animated:YES completion:nil];
        
        
        if (_loginView.phoneNum.text.length != 11) {
            [self showHint:@"手机号错误!"];
        }else if (_loginView.password.text.length == 0) {
            [self showHint:@"密码不能为空"];
        }else {
            NSString *password = [MyMD5 md5:_loginView.password.text];
            //开始拼接Json字符串
            NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:
                                           _loginView.phoneNum.text,@"mobile",
                                           password, @"password",nil];
            
            [self showHint:@"正在登陆" yOffset:-200];
            //拼接url
            NSString *str = @"user/login";
            NSString *urlStr = [NSString stringWithFormat:urlString, str];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [MyDataService requestURL:urlStr httpMethod:@"POST" params:dataDictionary completion:^(id result, NSError *error) {
                    NSLog(@"result --- %@",result);
                    
                    
                    [self hideHud];
                    
                    if (error) {
                        NSLog(@"%@", error);
                    }
                    
                    @try {
                        if (result) {
                            NSInteger isSuccess = [result[@"success"] integerValue];
                            if (isSuccess == 0)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self showHint:result[@"msg"] yOffset:-50];
                                });
                            }
                            else
                            {
                                NSDictionary *bodyDic = result[@"body"];
                                NSDictionary *userDic = bodyDic[@"User"];
                                
                                //保存用户id
                                _userId = userDic[@"id"];
                                //保存用户姓名
                                _userName = userDic[@"userName"];
                                _isTeacher = [userDic[@"isTeacher"] integerValue];
                                //是否有专业
                                self.isTeacherHaveMajor = bodyDic[@"isTeacherHaveMajor"];
                                
                                //是否隐藏姓名
                                _isPublicName = [bodyDic[@"isPublicName"] boolValue];
                                //是否隐藏照片
                                _isPublicPhoto = [bodyDic[@"isPublicPhoto"] boolValue];
                                
                                _authToken = bodyDic[@"authToken"];
                                
                                if (_isTeacher) {
                               
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self goMain:_isTeacher];
                                    });
                                    
                                }else if ([userDic[@"isStudent"] integerValue]) {
                                    NSLog(@"%@",result);
                                    NSDictionary *bodyDic = result[@"body"];
                                    NSDictionary *userDic = bodyDic[@"User"];
                                    //保存用户id
                                    _userId = userDic[@"id"];
                                    //保存用户姓名
                                    // _userName = userDic[@"userName"];
                                    _isStudent = [userDic[@"_isStudent"] integerValue];
                                    //是否有专业
                                    self.isStudentHaveMajor = bodyDic[@"isStudentHaveMajor"];
                                    
                                    //是否隐藏姓名
                                    _isPublicName = [bodyDic[@"isPublicName"] boolValue];
                                    //是否隐藏照片
                                    _isPublicPhoto = [bodyDic[@"isPublicPhoto"] boolValue];
                                    
                                    _authToken = bodyDic[@"authToken"];
                                    
                                    if ([self.isStudentHaveMajor integerValue] != 0) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self goSMain:_isStudent];
                                        });
                                    }else {
                                        
                                        RelationController *relationVC = [[RelationController alloc] init];
                                        
//                                        relationVC.isStudentHaveMajor = YES;
//                                        relationVC.userId = _userId;
//                                        relationVC.phoneNumber = self.phoneTextFild.text;
//                                        relationVC.passWord = self.passTextFild.text;
//                                        relationVC.authToken = _authToken;
//                                        relationVC.isPublicName = _isPublicName;
//                                        relationVC.isPublicPhoto = _isPublicPhoto;
                                        [self.navigationController pushViewController:relationVC animated:YES];
                                    }
                                }
                                //向服务器传送id用于绑定
                                [self performSelector:@selector(_tieID) withObject:nil afterDelay:1.0];
                            }
                        }else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self showHint:@"服务器响应失败"];
                            });
                        }
                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
                }];
            });
        }
        
    }else//忘记密码
    {
        ForgetPassController *forgetPassVc = [[ForgetPassController alloc] init];
        [self.navigationController pushViewController:forgetPassVc animated:YES];
  
    }
}



- (void)goMain:(NSInteger)isTeachaer {
    
    //保存数据到NSUserDefaults
    [self saveTeaUserDefaults];
    
    //跳转到主界面
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.isTeacher = isTeachaer;
    [appDelegate goMain];
}

//进入学生界面
-(void)goSMain:(NSInteger)isStudent {
    //保存数据到NSUserDefaults
    [self saveStuUserDefaults];
    
    //跳转到主界面
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.isStudent = isStudent;
    [appDelegate goMain];
}

//保存学生数据到NSUserDefaults
-(void)saveStuUserDefaults {
    
    NSString *phone = _loginView.phoneNum.text;
    NSString *pass = _loginView.password.text;
    NSInteger isTeacher = NO;
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    NSLog(@"%@", _userId);
    //    //保存用户的姓名
    //    _userName = self.nameText.text;
    //保存用户的姓名
    [userDefaults setObject:_userName forKey:@"userName"];
    //authToken
    [userDefaults setObject:_authToken forKey:@"authToken"];
    //是否隐藏姓名
    [userDefaults setObject:[NSString stringWithFormat:@"%d",_isPublicName] forKey:@"isPublicName"];
    //是否隐藏图片
    [userDefaults setObject:[NSString stringWithFormat:@"%d", _isPublicPhoto] forKey:@"isPublicPhoto"];
    //保存用户ID
    [userDefaults setObject:[NSString stringWithFormat:@"%@", _userId] forKey:@"userID"];
    //保存用户手机号
    [userDefaults setObject:phone forKey:@"phoneNumber"];
    //保存用户登陆密码
    [userDefaults setObject:pass forKey:@"passWord"];
    //保存用户是否是老师
    [userDefaults setObject:[NSString stringWithFormat:@"%ld", (long)isTeacher] forKey:@"isTeacher"];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}

//保存数据到NSUserDefaults
-(void)saveTeaUserDefaults
{
    NSString *phoneNumber = _loginView.phoneNum.text;
    NSString *passWord = _loginView.password.text;
    NSInteger isTeacher = _isTeacher;
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    NSLog(@"%@", _userId);
    //是否隐藏姓名
    [userDefaults setObject:[NSString stringWithFormat:@"%d",_isPublicName] forKey:@"isPublicName"];
    //是否隐藏图片
    [userDefaults setObject:[NSString stringWithFormat:@"%d", _isPublicPhoto] forKey:@"isPublicPhoto"];
    //authToken
    [userDefaults setObject:_authToken forKey:@"authToken"];
    //保存用户的姓名
    [userDefaults setObject:_userName forKey:@"userName"];
    //保存用户ID
    [userDefaults setObject:[NSString stringWithFormat:@"%@", _userId] forKey:@"userID"];
    //保存用户手机号
    [userDefaults setObject:phoneNumber forKey:@"phoneNumber"];
    //保存用户登陆密码
    [userDefaults setObject:passWord forKey:@"passWord"];
    //保存用户是否是老师
    [userDefaults setObject:[NSString stringWithFormat:@"%ld", (long)isTeacher] forKey:@"isTeacher"];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}


#pragma mark -- 触摸编辑区外关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}


//设置导航栏透明
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
@end
