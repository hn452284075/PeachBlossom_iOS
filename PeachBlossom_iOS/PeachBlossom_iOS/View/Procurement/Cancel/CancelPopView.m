//
//  CancelPopView.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CancelPopView.h"
#import "UIView+BlockGesture.h"
#import "CancelTableViewCell.h"
static CancelPopView *_cancelPopView = nil;
static dispatch_once_t onceToken;
@implementation CancelPopView
+ (instancetype)sharedInstance{
    
       dispatch_once(&onceToken, ^{
           
           _cancelPopView  = [[CancelPopView alloc] init];
           
       });
       
       return _cancelPopView;
}

-(void)show:(SeletecdTypeBlock)block{
    self.dataArr = @[@"不想买了",@"信息填写错，要重新拍",@"运费太贵/不包邮",@"运费太贵/不包邮",@"其他原因"];
    
    _seletecdTypeBlock=block;
    _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _viewBG.tag=222;
    _viewBG.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_viewBG];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tableView];
    WEAK_SELF
    [_viewBG addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self colse];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
                
         weak_self.tableView.frame = CGRectMake(0, kScreenHeight-380, kScreenWidth, 380);
                
                
         } completion:^(BOOL finished) {
            
            
    }];
}

- (void)colse{
    
  onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    
  _cancelPopView = nil;
  WEAK_SELF
    [UIView animateWithDuration:0.3 animations:^{
        
        weak_self.tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 380);
        

    } completion:^(BOOL finished) {
         [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
         [[[UIApplication sharedApplication].keyWindow viewWithTag:100] removeFromSuperview];
    }];
     
     
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kScreenHeight, kScreenWidth, 380) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.tag=100;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        v.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
        line.backgroundColor = UIColorFromRGB(0xcccccc);
        [v addSubview:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-45, 0, 90, 50)];
        label.textAlignment = 1;
        label.text = @"取消原因";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = KCOLOR_MAIN_TEXT;

        [v addSubview:label];
         
        _tableView.tableHeaderView = v;
        
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
        [footer setBackgroundColor:[UIColor whiteColor]];
           self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
           self.sureBtn.layer.cornerRadius = 20.0;
           self.sureBtn.layer.masksToBounds = YES;
           [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
           [self.sureBtn setBackgroundColor:KCOLOR_Main];
           self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
           [footer addSubview:self.sureBtn];
           [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.center.mas_equalTo(footer);
               make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, 40));
           }];
           self.tableView.tableFooterView = footer;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [NSString stringWithFormat:@"CancelTableViewCell%ld",indexPath.row];
    CancelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CancelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
    }
    [self configCell:cell data:[self.dataArr objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
}


- (void)configCell:(CancelTableViewCell *)cell data:(NSString *)data indexPath:(NSIndexPath *)indexPath{
    
    cell.titleLabel.text = data;
    if (self.currentIndex == indexPath.row) {
        cell.stateView.image =  [UIImage imageNamed:@"cancelSeletecd"];
    }else{
        cell.stateView.image =  [UIImage imageNamed:@"cancelDefault"];
    }
    
}


 

-(void)sureClick{
    emptyBlock(self.seletecdTypeBlock,self.dataArr[self.currentIndex]);
    [self colse];
}
@end
