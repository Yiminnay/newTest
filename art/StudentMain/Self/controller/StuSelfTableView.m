//
//  StuSelfTableView.m
//  art
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 sunyan. All rights reserved.
//

#import "StuSelfTableView.h"

@interface StuSelfTableView()

@property(nonatomic,strong)NSArray *titleArray1;
@property(nonatomic,strong)NSArray *imageArray1;
@property(nonatomic,strong)NSArray *titleArray2;
@property(nonatomic,strong)NSArray *imageArray2;


@end

static NSString *stuSelfTableViewID = @"stuSelfTableView-cell";
@implementation StuSelfTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate= self;
        self.dataSource = self;
        self.rowHeight = 50;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:stuSelfTableViewID];
        
        [self loadArrayMessage];
    }
    return self;
}


- (void)loadArrayMessage{
    _titleArray1 = @[@"我的资料",@"地址管理",@"时间管理"];
    _imageArray1= @[@"gister_buttom_role",@"gister_buttom_role",@"gister_buttom_role"];
    _titleArray2 = @[@"我的老师",@"我的作品",@"二维码"];
    _imageArray2= @[@"gister_checkbox_select",@"gister_buttom_role",@"gister_buttom_role"];
}

#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 )
    {
        return 3;
    }
        
        return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stuSelfTableViewID forIndexPath:indexPath];
    cell.backgroundColor = bgColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = _titleArray1[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:_imageArray1[indexPath.row]];
        
        if (indexPath.row != 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, cell.height-1, SCREEN_WIDTH-15, 1)];
            view.backgroundColor = Color(82, 82, 82, 1);
            [cell addSubview:view];
        }
    }else if (indexPath.section == 1)
    {
        cell.textLabel.text = _titleArray2[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:_imageArray2[indexPath.row]];
        if (indexPath.row != 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, cell.height-1, SCREEN_WIDTH-15, 1)];
            view.backgroundColor = Color(82, 82, 82, 1);
            [cell addSubview:view];
        }
    }else if (indexPath.section == 2)
    {
        cell.textLabel.text = @"设置";
        
        cell.imageView.image = [UIImage imageNamed:@"gister_buttom_people"];
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 25;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return 50;
    }
    return 20;
    
}
@end
