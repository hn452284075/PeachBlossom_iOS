//
//  SearchGoodsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchGoodsVC.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "UIView+Frame.h"
#import "UIImage+extern.h"
@interface SearchGoodsVC ()
{
    UIView  *lineView;
}
@property (nonatomic,strong)UITextField *searchField;
@property (nonatomic,assign)NSInteger indexBtn;
@property (nonatomic,strong)NSMutableArray *buttonArr;
@end

@implementation SearchGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initTopView];
}

#pragma mark ------------------------Init---------------------------------
- (void)_initTopView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 58, 30);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = CUSTOMFONT(14);
    [btn setBackgroundColor:KCOLOR_Main];
    btn.layer.cornerRadius=15;
    [btn addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-10],rightItem];
    
    // 创建搜索框
    UIView *seachView = [[UIView alloc] initWithFrame:CGRectMake(42.5, 7, kScreenWidth-125, 30)];
    seachView.backgroundColor = [UIColor whiteColor];
    seachView.layer.cornerRadius=15;
    seachView.layer.borderColor=KCOLOR_Main.CGColor;
    seachView.layer.borderWidth=1.0f;
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seachBtn.frame =CGRectMake(15,5, 20, 20);
   [seachBtn setImage:IMAGE(@"home-seacher") forState:UIControlStateNormal];
   [seachBtn setTitleColor:KTextColor forState:UIControlStateNormal];
   seachBtn.titleLabel.font= CUSTOMFONT(12);
   [seachView addSubview:seachBtn];
    // 创建文本框
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(seachBtn.right+5, 0, seachView.width-seachBtn.right-5, 30)];
    // 设置文本框的字体
    _searchField.font = [UIFont systemFontOfSize:12];
    // 设置文本的颜色
    _searchField.textColor = KTextColor;
    // 设置文本框的风格
    _searchField.borderStyle = UITextBorderStyleNone;
    // 设置文本框提示内容
    _searchField.placeholder = @"请输入搜索关键词";
    _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [seachView addSubview:_searchField];

    self.navigationItem.titleView = seachView;
    
    UIView *seletecdBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    seletecdBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seletecdBgView];
    
    _buttonArr = [[NSMutableArray alloc]init];
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
    lineV.backgroundColor = KLineColor;
    [seletecdBgView addSubview:lineV];
    NSArray  *allTitllesArr = @[@"货品",@"店铺"];
       UIButton *toBtn;
       for (int i=0; i<allTitllesArr.count; i++) {
           UIButton *senderBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2*i, 0, kScreenWidth/2, seletecdBgView.frame.size.height-2)];
           senderBtn.titleLabel.font=[UIFont systemFontOfSize:17];
           [senderBtn setTitle:allTitllesArr[i] forState:UIControlStateNormal];
           [senderBtn setTitleColor:KCOLOR_MAIN_TEXT forState:UIControlStateNormal];
           [senderBtn setTitleColor:KCOLOR_Main forState:UIControlStateSelected];
           senderBtn.tag=1000+i;
           [seletecdBgView addSubview:senderBtn];
           [senderBtn addTarget:self action:@selector(senderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           if (i ==_indexBtn) {
               senderBtn.selected=YES;
               toBtn =senderBtn;
           }
           
           [_buttonArr addObject:senderBtn];
       }
       if (_indexBtn ==0) {
        lineView=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2/2-12, seletecdBgView.height/2+12,24, 3)];
       }
       lineView.layer.cornerRadius=1.5;
       lineView.backgroundColor=KCOLOR_Main;
       [seletecdBgView addSubview:lineView];
}




#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
//点击的头部按钮方法
-(void)senderBtnClick:(UIButton *)sender{
    for (UIButton *btn in _buttonArr) {
        
        if (btn == sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    __block UIView *line=lineView;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=line.frame;
        rect.origin.x=sender.frame.origin.x+(kScreenWidth/2/2-12);
        line.frame=rect;
    }];
    if (sender.tag == 1000) {
        _indexBtn = 0;
    }else
        _indexBtn = 1;
    
}

-(void)searchBarClick{
    
    
}


#pragma mark ------------------------Getter / Setter----------------------

@end
