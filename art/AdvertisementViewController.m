//
//  AdvertisementViewController.m
//  art
//
//  Created by sunyan on 15/10/10.
//  Copyright (c) 2015年 SJWL-HJT. All rights reserved.
//

//三张启动图
#import "AdvertisementViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

#define kIMGCount 3

@interface AdvertisementViewController () <UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView* scroll;
@property(strong,nonatomic)UIPageControl* page;

@end

@implementation AdvertisementViewController

- (void)dealloc {
    NSLog(@"控制器销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     *创建并添加UIScrollView
     */
    _scroll=[[UIScrollView alloc]init];
    _scroll.frame=self.view.bounds;
    [self.view addSubview:_scroll];
    
    CGFloat width=_scroll.frame.size.width;
    CGFloat height=_scroll.frame.size.height;
    NSArray *array = @[@"diyi",@"欢迎页",@"欢迎页2"];
    for (int i=0; i<kIMGCount; i++) {
        UIImageView* imageView=[[UIImageView alloc]init];
        CGFloat imageX=i*width;
        CGFloat imageY=0;
        imageView.frame=CGRectMake(imageX, imageY, width, height);
        imageView.image=[UIImage imageNamed:array[i]];

        [_scroll addSubview:imageView];
        /**
         *在最后一张图片添加进入主页的按钮
         */
        if (i==kIMGCount-1){
            [self setupLastImageView:imageView];
        }
    }
    _scroll.contentSize=CGSizeMake(kIMGCount*width, 0);
    _scroll.pagingEnabled=YES;
    _scroll.showsHorizontalScrollIndicator=NO;
    _scroll.showsVerticalScrollIndicator=NO;
    _scroll.bounces=NO;
    _scroll.delegate=self;
}
-(void)setupLastImageView:(UIImageView*)imageView {
    
    imageView.userInteractionEnabled=YES;
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(110, SCREEN_HEIGHT-120, SCREEN_WIDTH-220, 55);
    btn.backgroundColor =[UIColor clearColor];

    [btn addTarget:self action:@selector(jumpMainPage) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
}
#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset=scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    int pageNum=(offsetX+0.5*_scroll.frame.size.width)/_scroll.frame.size.width;
    _page.currentPage=pageNum;
}
#pragma mark-btn的点击监听事件
-(void)jumpMainPage {
    //跳转到登录界面
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate goLoginViewController];
}


@end
