//
//  LoginViewController.h
//  iYi
//
//  Created by sunyan on 15/10/10.
//  Copyright (c) 2015年 SJWL-HJT. All rights reserved.
//


#import "BaseViewController.h"

@interface LoginViewController :BaseViewController{
    NSInteger _isTeacher;
    NSInteger _isStudent;
    
    NSString *_authToken;
    
    //是否隐藏姓名
    BOOL _isPublicName;
    //是否隐藏照片
    BOOL _isPublicPhoto;
}

//登陆用户的id
@property (nonatomic, strong)NSNumber *userId;
//登录用户的姓名
@property (nonatomic, copy)NSString *userName;
//登陆用户的手机号
@property (nonatomic, strong)NSNumber *userPhoneNumber;
//登录用户是否有专业
@property (nonatomic, strong)NSNumber *isTeacherHaveMajor;
@property (nonatomic, strong)NSNumber *isStudentHaveMajor;

@end
