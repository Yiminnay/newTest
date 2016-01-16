//
//  RegisterView.h
//  art
//
//  Created by Apple on 16/1/14.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterView;

@protocol RegisterViewDelegate <NSObject>

- (void)RegisterView:(RegisterView *)registerView didClick:(UIButton *)sender;

@end

@interface RegisterView : UIView

@property(nonatomic,weak) id<RegisterViewDelegate> delegete;

@property(nonatomic,strong)UIButton *checkButton;

@end
