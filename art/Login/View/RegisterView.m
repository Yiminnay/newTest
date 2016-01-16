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
    
    UIView *teaStuView;

    UIButton *_selectST;
    //三角形按钮
    UIButton *_selectButton;
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
    UIControl *selectBtnC = [[UIControl alloc] init];
    selectBtnC.frame = CGRectMake(whiteView.bounds.size.width-54,0, 50,70);
    [selectBtnC addTarget:self action:@selector(_selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:selectBtnC];
    
    _selectButton = [[UIButton alloc] init];
    _selectButton.frame= CGRectMake(30,34, 11,6);
    [_selectButton setImage:[UIImage imageNamed:@"gister_buttom_triangle"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"gister_buttom_triangle_click"] forState:UIControlStateSelected];
    _selectButton.selected = NO;
    [selectBtnC addSubview:_selectButton];
    
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

    //选择角色（老师学生）父视图
    teaStuView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width-13-105, 32+20, 105, 90)];
    teaStuView.backgroundColor = [UIColor whiteColor];
    teaStuView.layer.cornerRadius = 5;
    teaStuView.clipsToBounds = YES;
    teaStuView.layer.borderWidth = 1;
    teaStuView.layer.borderColor = Color(238, 238, 238, 1).CGColor;
    teaStuView.hidden = YES;
    [self addSubview:teaStuView];
    
    UIButton *teacherButton = [[UIButton alloc] init];
    teacherButton.frame= CGRectMake(0, 0,105,45);
    teacherButton.backgroundColor =Color(245, 245, 245, 1);
    teacherButton.layer.cornerRadius = 5;
    teacherButton.selected = YES;
    teacherButton.clipsToBounds = YES;
    [teacherButton setTitle:@"老师" forState:UIControlStateNormal];
    [teacherButton setTitleColor:Color(75, 75, 75, 1) forState:UIControlStateNormal];
    [teacherButton addTarget:self action:@selector(teaStuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectST = teacherButton;
    [teaStuView addSubview:teacherButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, teaStuView.bounds.size.width, 1)];
    lineView.backgroundColor = Color(238, 238, 238, 1);
    [teaStuView addSubview:lineView];
    
    UIButton  *studentButton = [[UIButton alloc] init];
    studentButton.frame= CGRectMake(0, 45,105,45);
    studentButton.layer.cornerRadius = 5;
    studentButton.clipsToBounds = YES;
    studentButton.selected = NO;
    [studentButton setTitle:@"学生" forState:UIControlStateNormal];
    [studentButton setTitleColor:Color(75, 75, 75, 1) forState:UIControlStateNormal];
    [studentButton addTarget:self action:@selector(teaStuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [teaStuView addSubview:studentButton];
    

    

    
}

//三角按钮（选择角色）
- (void)_selectButtonAction:(UIButton *)sender{
    _selectButton.selected = !_selectButton.selected;
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        teaStuView.hidden = NO;
        
    }else
    {
        teaStuView.hidden = YES;
    }
}

//选择角色（老师学生）
- (void)teaStuButtonAction:(UIButton *)sender{
   

    _selectST.selected = NO;
    _selectST.backgroundColor = [UIColor clearColor];
    
    sender.selected = YES;
    sender.backgroundColor = Color(245, 245, 245, 1);
    _selectST = sender;
  
    
}

/**
 *  记住密码 1
 *  下一步 2
 */
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
    teaStuView.hidden =YES;
    
}

@end
