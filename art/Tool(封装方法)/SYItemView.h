 //
//  SYItemView.h
//  MyMovies
//
//  Created by imac on 15/9/1.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYItemView : UIControl
/**设置图片*/
-(void)setItemImage:(UIImage *)image forControlState:(UIControlState )state;
/**设置标题*/
-(void)setItemTitle:(NSString *)title withSpecialTextColor:(UIColor *)color;
@end
