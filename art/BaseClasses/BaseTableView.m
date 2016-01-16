//
//  BaseTableView.m
//  art
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if ([super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


@end
