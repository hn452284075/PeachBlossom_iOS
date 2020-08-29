//
//  SearchViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/18.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchViewController.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "SearchListVC.h"
#import "MycommonTableView.h"
#import "SearchCell.h"
#import "MyCommonCollectionView.h"
#import "AddressCell.h"
#import "EWAddressModel.h"
#import "AddressHeaderView.h"
#import "AddressShowView.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "UIView+Frame.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView  *lineView;
}
@property (nonatomic,strong)UITextField *searchField;
@property (nonatomic,assign)NSInteger indexBtn;
@property (nonatomic,assign)NSInteger typeindexBtn;
@property (nonatomic,strong)NSMutableArray *buttonArr;
@property (nonatomic,strong)NSMutableArray *buttonTypeArr;
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@property (nonatomic,strong)MycommonTableView *listTableView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,strong)AddressShowView *addressShowView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _initTopView];
    [self.view addSubview:self.listTableView];
    

    [_listTableView configureTableAfterRequestPagingData:@[@"",@"",@"",@"",@"",@""]];
 
           
}


#pragma mark ------------------------Init---------------------------------
- (void)_initTopView{
    [self removeLine];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 58, 30);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = CUSTOMFONT(14);
    [btn setBackgroundColor:KCOLOR_Main];
    btn.layer.cornerRadius=15;
    [btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSArray  *allTitllesArr = @[@"全部",@"附近"];
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
    
    
    //条件选择view
    UIView *typeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 40)];
       typeBgView.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:typeBgView];
       
       _buttonTypeArr = [[NSMutableArray alloc]init];
       UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
       lView.backgroundColor = KLineColor;
       [typeBgView addSubview:lineV];
       NSArray  *titllesArr = @[@"产地",@"品类",@"销量",@"筛选"];
          UIButton *currenBtn;
          for (int i=0; i<titllesArr.count; i++) {
              UIButton *senderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
              senderBtn.frame = CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, typeBgView.frame.size.height-2);
              senderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
              [senderBtn setTitle:titllesArr[i] forState:UIControlStateNormal];
              [senderBtn setTitleColor:KCOLOR_MAIN_TEXT forState:UIControlStateNormal];
              [senderBtn setTitleColor:KCOLOR_Main forState:UIControlStateSelected];
              if (i==0||i==1) {
              [senderBtn setImage:IMAGE(@"grayArrow") forState:UIControlStateNormal];
              [senderBtn setImage:IMAGE(@"greenArrow") forState:UIControlStateSelected];
              [senderBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
              [senderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
              }
             
              if (i==3) {
              [senderBtn setImage:IMAGE(@"saixuan") forState:UIControlStateNormal];
                  [senderBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
                  [senderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
              }
              
              senderBtn.tag=2000+i;
              [typeBgView addSubview:senderBtn];
              [senderBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
              if (i ==_typeindexBtn) {
                  senderBtn.selected=YES;
                  currenBtn =senderBtn;
              }
              if (i ==2) {//灰色线
                     UIView *smallView=[[UIView alloc]initWithFrame:CGRectMake(senderBtn.frame.size.width-1, 12, 1, 15)];
                     smallView.backgroundColor=[UIColor colorWithRed:0.812 green:0.812 blue:0.812 alpha:0.5];
                     [senderBtn addSubview:smallView];
                }
              
              [_buttonTypeArr addObject:senderBtn];
          }
    
    
}
 
 




#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
//全部  附近---点击
-(void)senderBtnClick:(UIButton *)sender{
    for (UIButton *btn in _buttonArr) {
        
        if (btn == sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    __block UIView *line=lineView;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=line.frame;
        rect.origin.x=sender.frame.origin.x+(kScreenWidth/2/2-12);
        line.frame=rect;
    }];
    if (sender.tag == 1000) {
        _indexBtn = 0;
    }else{
        _indexBtn = 1;
    }
    
}
//产地 品类 销量 筛选--点击
-(void)typeBtnClick:(UIButton *)sender{
    for (UIButton *btn in _buttonTypeArr) {
           
       if (btn == sender) {
           btn.selected = YES;
       }else{
           btn.selected = NO;
       }
    }
    
    if (sender.tag == 2000) {
        _typeindexBtn = 0;
        if (_addressShowView==nil) {
            
            _addressShowView = [[AddressShowView alloc]initWithAddresFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight-80-kStatusBarAndNavigationBarHeight)];
            WEAK_SELF
            _addressShowView.addressBlock = ^(NSString * _Nonnull str) {
                NSLog(@"%@",str);
                weak_self.addressShowView=nil;
            };
            
            [self.view addSubview:_addressShowView];
        }
       
        
    }else if (sender.tag == 2001){
        _typeindexBtn = 1;
    }else if (sender.tag == 2002){
        _typeindexBtn = 2;
    }else{
        _typeindexBtn = 3;
       }
    
}


 

- (IBAction)goBackClick:(id)sender{
    [self goBack];
}

-(void)searchClick{
    
}

#pragma mark ------------------------Delegate-----------------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0,80,kScreenWidth, kScreenHeight-80-kStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.noDataLogicModule.nodataAlertTitle=@"暂无血糖测量方案";
        _listTableView.noDataLogicModule.nodataAlertImage=@"pic-default-01"; _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 163.0f;
        
        [_listTableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
        WEAK_SELF
        [_listTableView configurecellNibName:@"SearchCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            SearchListVC *vc = [[SearchListVC alloc]init];
            [self  navigatePushViewController:vc animate:YES];
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
          
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
           
            
        }];
        
        
        
    }
    
    return _listTableView;
}



 


 
@end
