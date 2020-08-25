//
//  ZZTabbarItemView.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ZZTabbarItemView.h"
#import "TabbarButton.h"

const int DBTabTotalCount = 4;

@interface ZZTabbarItemView (){
    TabbarButton *_selectedButton;
    NSUInteger _tabButtonCount;
}
@end

@implementation ZZTabbarItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tabButtonCount = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineView.backgroundColor = KLineColor;
        [self addSubview:lineView];
//        [self addPlusBtn];
    }
    return self;
}


//设置下标
-(void)setBadgeValue:(NSString *)badgeValue{
    
}

//添加中间发布按钮
#pragma mark 添加+号
- (void)addPlusBtn
{
    self.centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.centerbtn setImage:[UIImage imageNamed:@"添加按钮"] forState:UIControlStateNormal];
//    CGFloat btnBgHW = self.frame.size.height - 10;
 
    self.centerbtn.bounds = (CGRect){CGPointZero, {52.5 , 52.5}};
    self.centerbtn.adjustsImageWhenHighlighted = NO;
    self.centerbtn.center = CGPointMake(self.frame.size.width * 0.5,self.frame.size.height/3);
    [self.centerbtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerbtn];
}

//点击中间按钮触发代理事件
- (void)plusClick
{
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}



//初始化添加默认按钮
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    
//    if (_tabButtonCount >= DBTabTotalCount) return;
    _lastIndex = 10;
    // 1.创建按钮
    TabbarButton *button = [TabbarButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置背景
    button.item = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.添加
    [self addSubview:button];
    
    // 4.默认选中第0个按钮
    button.tag = _tabButtonCount+10;
    
    if (_lastIndex == _tabButtonCount+10) {
        [self buttonClick:button];
        button.selected = YES;
    }
    
    // 5.设置按钮frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / (DBTabTotalCount);
    CGFloat buttonX = _tabButtonCount * buttonW;
    //添加中间按钮打开
//        if (_tabButtonCount >= DBTabTotalCount * 0.5) {
//            buttonX += buttonW;
//        }
    CGFloat buttonH = self.frame.size.height;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    _tabButtonCount++;
    
}


#pragma mark 监听按钮点击【触发代理事件】
- (void)buttonClick:(TabbarButton *)button
{
    if (_lastIndex ==button.tag) {
        return;
    }
    // 1.通知代理
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        NSInteger from = _selectedButton ? _selectedButton.tag : -1;
        [_delegate tabBar:self didSelectButtonFrom:from to:button.tag-10];
    }
    
    // 2.切换按钮状态
    
    [self _seletedIndex:button.tag];
    
    //    _selectedButton.selected = NO;
    //    button.selected = YES;
    //    _selectedButton = button;
}

- (void)_seletedIndex:(NSInteger)index{
    
    if (_lastIndex !=index) {
        TabbarButton *lastBtn = [self viewWithTag:_lastIndex];
        lastBtn.selected  = NO;
        
        TabbarButton *newBtn = [self viewWithTag:index];
        newBtn.selected  = YES;
        
        _lastIndex = index;
    }
}

@end
