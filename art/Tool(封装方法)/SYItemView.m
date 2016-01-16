//
//  SYItemView.m
//  MyMovies
//
//  Created by imac on 15/9/1.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import "SYItemView.h"
@interface SYItemView(){
    UILabel *_itemLable;   //标题文本
    UIImageView *_itemImageView ;   //按钮图片视图
}
@end
@implementation SYItemView

//初始化
-(instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    if (self !=nil) {
    CGFloat itemWide = CGRectGetWidth(frame);//获取宽高，取当前self的frame值
    CGFloat itemHeight = CGRectGetHeight(frame);
    //图片22*20
    _itemImageView = [[UIImageView alloc ] initWithFrame:CGRectMake((itemWide-22)*0.5, 10.f, 22.f, 20.f)];
        
    //设置图片显示模式
    _itemImageView.contentMode = UIViewContentModeScaleAspectFit;//不改变宽高比
    [self addSubview:_itemImageView];
    
    //标题
    _itemLable = [[UILabel alloc] initWithFrame:CGRectMake(0, itemHeight-20.f, itemWide, 20.f)];
    _itemLable.textColor = [UIColor whiteColor];
    _itemLable.font = [UIFont systemFontOfSize:10.f];
    _itemLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_itemLable];
}
    return self;
    
}


// 设置按钮的图片
-(void)setItemImage:(UIImage *)image forControlState:(UIControlState )state{
    if (state ==UIControlStateNormal) {
        _itemImageView.image =image;//普通状态图片
    } else if (state == UIControlStateSelected){
        _itemImageView.highlightedImage = image;//选中
    }
}

/** 设置标题*/
-(void)setItemTitle:(NSString *)title withSpecialTextColor:(UIColor *)color{
    _itemLable.text = title;
    _itemLable.highlightedTextColor = color;
}

/**设置按钮是否被选中*/
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    // 当按钮被选中的时候，切换子视图的状态
    _itemImageView.highlighted = selected;
    _itemLable.highlighted =selected;
    
}

@end
