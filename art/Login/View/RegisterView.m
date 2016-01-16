//
//  RegisterView.m
//  art
//
//  Created by Apple on 16/1/14.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView()<UITextFieldDelegate>

@end

@implementation RegisterView{
    
    UIView *_teaStuView;
    UIButton *_teacherButton;
    UIButton *_studentButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        //配置登陆界面
        [self configureRegisterView];

    }
    return self;
}


- (void)configureRegisterView{
    //背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:bgView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, 210)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    whiteView.clipsToBounds = YES;
    [bgView addSubview:whiteView];
    

     NSArray *imgArr = @[@"gister_buttom_role",@"gister_buttom_people",@"gister_buttom_lock"];
     CGFloat imageW=18;
     CGFloat imageH=18;
    NSArray *placeHolder = @[@"请选择角色",@"请输入用户名",@"请输入密码"];
    CGFloat textFieldW=200;
    CGFloat textFieldH=70;
    for (int i =0; i<imgArr.count; i++) {
        //图
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX=18;
        CGFloat imageY=26+i*70;
        imageView.frame =CGRectMake(imageX, imageY, imageW, imageH);
        imageView.image = [UIImage imageNamed:imgArr[i]];
        imageView.userInteractionEnabled = YES;
        [whiteView addSubview:imageView];
        
        //内容
        CGFloat textFieldX=52;
        CGFloat textFieldY=0+i*70;
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
        textField.placeholder = placeHolder[i];
        textField.tag = i;
        textField.delegate = self;
        [whiteView addSubview:textField];
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*(i+1), bgView.bounds.size.width, 1)];
        lineView.backgroundColor = Color(238, 238, 238, 1);
        [whiteView addSubview:lineView];
     
    }
    
    UIButton *selectButton = [[UIButton alloc] init];
    selectButton.frame= CGRectMake(whiteView.bounds.size.width-24,32, 11,6);
    [selectButton setImage:[UIImage imageNamed:@"gister_buttom_triangle"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"gister_buttom_triangle_click"] forState:UIControlStateSelected];
    selectButton.selected = NO;
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:selectButton];
    
    UIControl *bgControl = [[UIControl alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(whiteView.frame)+17, 100, 15)];
    [bgControl addTarget:self action:@selector(bgControlButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgControl];
    
    _checkButton = [[UIButton alloc] init];
    _checkButton.frame= CGRectMake(17, 0, 15, 15);
    _checkButton.backgroundColor = [UIColor whiteColor];
    _checkButton.layer.cornerRadius = 1;
    _checkButton.clipsToBounds = YES;
    [_checkButton setImage:[UIImage imageNamed:@"gister_checkbox_select"] forState:UIControlStateSelected];
    _checkButton.selected = NO;
    _checkButton.tag  = 1;
    [_checkButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgControl addSubview:_checkButton];
    
    UILabel *remerberLabel = [[UILabel alloc] init];
    remerberLabel.frame = CGRectMake(CGRectGetMidX(_checkButton.frame)+11, 0, 100, 15);
    remerberLabel.text = @"记住密码";
    remerberLabel.textColor = [UIColor whiteColor];
    remerberLabel.font = [UIFont systemFontOfSize:14];
    [bgControl addSubview:remerberLabel];

  
    UIButton *nextButton = [[UIButton alloc] init];
    nextButton.frame= CGRectMake(0, CGRectGetMaxY(whiteView.frame)+44+32, bgView.bounds.size.width, 46);
    nextButton.backgroundColor = Color(244, 73, 51, 1);
    nextButton.layer.cornerRadius = 8;
    nextButton.clipsToBounds = YES;
    nextButton.tag = 2;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:nextButton];

    
}

//选择老师学生
- (void)selectButtonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        _teaStuView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width-13-105, 32+20, 105, 90)];
        _teaStuView.backgroundColor = [UIColor whiteColor];
        _teaStuView.layer.cornerRadius = 5;
        _teaStuView.clipsToBounds = YES;
        _teaStuView.layer.borderWidth = 1;
        _teaStuView.layer.borderColor = Color(238, 238, 238, 1).CGColor;
        [self addSubview:_teaStuView];
        
        
        _teacherButton = [[UIButton alloc] init];
        _teacherButton.frame= CGRectMake(0, 0,105,45);
        _teacherButton.backgroundColor =Color(245, 245, 245, 1);
        _teacherButton.layer.cornerRadius = 5;
        _teacherButton.selected = YES;
        _teacherButton.clipsToBounds = YES;
        [_teacherButton setTitle:@"老师" forState:UIControlStateNormal];
        [_teacherButton setTitleColor:Color(75, 75, 75, 1) forState:UIControlStateNormal];
        [_teacherButton addTarget:self action:@selector(teaStuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_teaStuView addSubview:_teacherButton];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, _teaStuView.bounds.size.width, 1)];
        lineView.backgroundColor = Color(238, 238, 238, 1);
        [_teaStuView addSubview:lineView];
        
        
        _studentButton = [[UIButton alloc] init];
        _studentButton.frame= CGRectMake(0, 45,105,45);
        _studentButton.layer.cornerRadius = 5;
        _studentButton.clipsToBounds = YES;
        _studentButton.selected = NO;
        [_studentButton setTitle:@"学生" forState:UIControlStateNormal];
        [_studentButton setTitleColor:Color(75, 75, 75, 1) forState:UIControlStateNormal];
        [_studentButton addTarget:self action:@selector(teaStuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_teaStuView addSubview:_studentButton];

        
    }else
    {
        _teaStuView.hidden = YES;
    }
}


- (void)teaStuButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_teacherButton.selected)
    {
        _teacherButton.backgroundColor = Color(245, 245, 245, 1);
        _studentButton.backgroundColor = [UIColor clearColor];
        _studentButton.selected = NO;
        
    }
    if (_studentButton.selected)
    {
        _studentButton.backgroundColor = Color(245, 245, 245, 1);
        _teacherButton.backgroundColor = [UIColor clearColor];
        _teacherButton.selected = NO;
    }
    
    
}


- (void)ButtonAction:(UIButton *)sender{
    if ([self.delegete respondsToSelector:@selector(RegisterView:didClick:)]) {
        [self.delegete RegisterView:self didClick:sender];
    }else
    {
        [self.viewController showHint:@"请稍后再试" yOffset:-200];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
}

- (void)bgControlButtonAction{
    _checkButton.selected = !_checkButton.selected;
}

#pragma mark -- 触摸编辑区外关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
    _teaStuView.hidden =YES;
    
}

@end
