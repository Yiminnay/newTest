//
//  MainViewController.m
//  MyMovies
//
//  Created by imac on 15/9/1.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import "MainViewController.h"
#import "TeaHomeController.h"
#import "TeaNewsController.h"
#import "TeaSelfController.h"
#import "StuHomeController.h"
#import "StuNewsController.h"
#import "StuSelfController.h"
#import "SYItemView.h"
#import "ArtNavigationController.h"



@interface MainViewController (){
    SYItemView *_lastItemView;
    NSArray *_vcs;      //装HomeVC NewsVC SelfVC
    BOOL isTeacher;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置子控制器
    [self _configureViewControllers];
    
    //搭建TabBarView
    [self _customTabBarView];
}




-(void)_configureViewControllers{
    
    
    
    TeaHomeController *teaHonVC = [[TeaHomeController alloc ] init];
    TeaNewsController *teaNewVc = [[TeaNewsController alloc ] init];
    TeaSelfController *teaSefVc = [[TeaSelfController alloc ] init];
    
    StuHomeController *stuHomeVC = [[StuHomeController alloc] init];
    StuNewsController *stuNewsVC = [[StuNewsController alloc] init];
    StuSelfController *stuSelfVC = [[StuSelfController alloc] init];
    
    if (isTeacher) {
        _vcs = @[teaHonVC,teaNewVc,teaSefVc];
    }else{
        _vcs = @[stuHomeVC,stuNewsVC,stuSelfVC];
    }
    
    
    NSMutableArray *naviga = [NSMutableArray arrayWithCapacity:_vcs.count];
    for (UIViewController *vc in _vcs) {
        
        //将3个UIViewController交给导航栏控制器
        ArtNavigationController *navigation =[[ArtNavigationController alloc ] initWithRootViewController:vc];
        //放到可变数组中
        [naviga addObject:navigation];
    }
    
    //可变数组中的UIViewController交给视图控制器
    self.viewControllers =naviga;
}


-(void)_customTabBarView{
    //1.移除标签栏
    for (UIView *subview in self.tabBar.subviews  ) {
      [subview removeFromSuperview];
    }
    //2.tabbarimage添加背景图片
    UIImageView *tabBarBGView = [[UIImageView alloc ] initWithFrame:self.tabBar.bounds];
    tabBarBGView.image = [UIImage imageNamed:@"tab_bg_all"];
//    UIView *v = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, kScreenWidth, 69)];
//    v.backgroundColor = [UIColor blackColor];
//    [self.tabBar addSubview:v];
    [self.tabBar addSubview:tabBarBGView];
    
    // 3.添加按钮
    // 按钮标题名
    NSArray *titles = @[@"首页",@"消息",@"我"];
    NSArray *imageNames = @[@"shouye",@"shouye",@"shouye"];
    NSArray *selectImageNames = @[@"shouye_sel",@"shouye_sel",@"shouye_sel"];
    
    CGFloat itemWidth =[UIScreen mainScreen].bounds.size.width/_vcs.count;
    //设置UITabBar栏的3个按钮
    for (int i = 0 ;i<_vcs.count; i++){
        SYItemView *sy = [[SYItemView alloc ] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 49.f)];
        [sy setItemImage:[UIImage imageNamed:imageNames[i]] forControlState:UIControlStateNormal ];
        [sy setItemImage:[UIImage imageNamed:selectImageNames[i]] forControlState:UIControlStateSelected];
        [sy setItemTitle:titles[i] withSpecialTextColor:[UIColor redColor]];
        
        [self.tabBar addSubview:sy];
        
        
        [sy addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        sy.tag = i;
        if (i ==0) {
            sy.selected = YES;
            _lastItemView = sy;//初始选中按钮
            
        }
    }
}

-(void)clickAction:(UIButton *)sender{
    // 取消上一个按钮的选中状态
    _lastItemView.selected = NO;
    // 更新标签控制器索引
    self.selectedIndex = sender.tag;
    
    // 更新按钮UI
    sender.selected = YES;
    
    // 记录当前选中的按钮
    _lastItemView =sender;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
