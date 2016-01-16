//
//  StuSelfController.m
//  art
//
//  Created by Apple on 16/1/14.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "StuSelfController.h"
#import "StuSelfTableView.h"

@implementation StuSelfController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我";
    [self configureStuSelfTableView];
}



- (void)configureStuSelfTableView{
    StuSelfTableView *_stuSelfTV = [[StuSelfTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _stuSelfTV.backgroundColor = bgColor;
    [self.view addSubview:_stuSelfTV];
}

@end
