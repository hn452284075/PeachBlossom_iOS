//
//  ScreeningVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/29.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ScreeningVC.h"
#import "CQSideBarManager.h"
#import "UIView+Frame.h"
@interface ScreeningVC ()
@property (nonatomic,strong)UITextField *minimumField;//最低价
@property (nonatomic,strong)UITextField *highestField;//最高价
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIButton *resetBtn;
@property (nonatomic,strong)NSMutableArray *buttonArr;
@end

@implementation ScreeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    self.buttonArr = [[NSMutableArray alloc]init];
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 39, 150, 16)];
    priceLabel.textColor = UIColorFromRGB(0x121212);
    priceLabel.textAlignment=0;
    priceLabel.text = @"价格区间";
    priceLabel.font=CUSTOMFONT(15);
    [self.view addSubview:priceLabel];
    
    
    // 创建文本框
    _minimumField = [[UITextField alloc] initWithFrame:CGRectMake(28, 72, (kScreenWidth-99)/2-35, 24)];
    _minimumField.font = [UIFont systemFontOfSize:12];
    _minimumField.textColor = KTextColor;
    _minimumField.borderStyle = UITextBorderStyleNone;
    _minimumField.placeholder = @"请输入最低价";
    _minimumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _minimumField.layer.cornerRadius=5;
    _minimumField.layer.borderWidth=0.5;
    _minimumField.layer.borderColor=UIColorFromRGB(0xDEDEDE).CGColor;
    _minimumField.backgroundColor=KViewBgColor;
    _minimumField.textAlignment =1;
    [self.view addSubview:_minimumField];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_minimumField.right+12, 83, 6, 2.5)];
    label.textColor = UIColorFromRGB(0x121212);
    label.textAlignment=1;
    label.text = @"~";
    label.font=CUSTOMFONT(12);
    [self.view addSubview:label];
    
    _highestField = [[UITextField alloc] initWithFrame:CGRectMake(label.right+12, 72,_minimumField.width, 24)];
    _highestField.font = [UIFont systemFontOfSize:12];
    _highestField.textColor = KTextColor;
    _highestField.borderStyle = UITextBorderStyleNone;
    _highestField.textAlignment =1;
    _highestField.placeholder = @"请输入最高价";
    _highestField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _highestField.layer.cornerRadius=5;
    _highestField.layer.borderWidth=0.5;
    _highestField.layer.borderColor=UIColorFromRGB(0xDEDEDE).CGColor;
    _highestField.backgroundColor=KViewBgColor;
    [self.view addSubview:_highestField];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 160, 150, 16)];
    timeLabel.textColor = UIColorFromRGB(0x121212);
    timeLabel.textAlignment=0;
    timeLabel.text = @"更新时间";
    timeLabel.font=CUSTOMFONT(15);
    [self.view addSubview:timeLabel];
    
    NSArray *array=@[@"最近一天",@"最近三天",@"最近一周",@"最近一个月"];
    CGFloat interval =14;//间隔
    CGFloat x=((kScreenWidth-99- ((kScreenWidth-99)/3)*2)/2-interval)/2;
    CGFloat h = 0;
    CGFloat y = 193;
    for (int i = 0; i<array.count; i++) {
      
       UIButton  *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
        btnView.backgroundColor = [UIColor redColor];
       CGFloat length=68;//此行固定宽度取消调此行恢复自动计算Tittle长度
        if (i==0) {
            btnView.selected=YES;
            btnView.layer.borderColor=KCOLOR_Main.CGColor;
            btnView.backgroundColor = [UIColor whiteColor];
        }else{
            btnView.layer.borderColor=UIColorFromRGB(0xdedede).CGColor;
            btnView.backgroundColor = KViewBgColor;
        }
        [btnView setTitleColor:UIColorFromRGB(0x9A9A9A) forState:UIControlStateNormal];
        [btnView setTitle:array[i] forState:UIControlStateNormal];
        btnView.titleLabel.font=CUSTOMFONT(12);
        [btnView setTitleColor:KCOLOR_Main forState:UIControlStateSelected];
        [btnView addTarget:self action:@selector(btnSeletecdClick:) forControlEvents:UIControlEventTouchUpInside];
        btnView.layer.cornerRadius=5;
        
        btnView.layer.borderWidth=0.5;
        
       btnView.frame =CGRectMake(interval + x, h+y, length, 24);
       //当button的位置超出屏幕边缘时换行 320只是button所在父视图的宽度
       if(interval + x + length> kScreenWidth-99){
        x=((kScreenWidth-99- ((kScreenWidth-99)/3)*2)/2-interval)/2;;//换行时将w置为0
           h = h + btnView.frame.size.height + 10;//距离父视图也变化

           btnView.frame =CGRectMake(interval + x, h+y, length, 24);//重设button的frame

       }
       x = btnView.frame.size.width + btnView.frame.origin.x;
       [_buttonArr addObject:btnView];
       [self.view addSubview:btnView];
        
    }
    
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.resetBtn.frame = CGRectMake(0,kScreenHeight-44, (kScreenWidth-99)/2, 44);
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    self.resetBtn.titleLabel.font=CUSTOMFONT(16);
    [self.resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.resetBtn setBackgroundColor:KTextColor];
    [self.view addSubview:self.resetBtn];
    
    self.confirmBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.confirmBtn.frame = CGRectMake((kScreenWidth-99)/2,kScreenHeight-44, (kScreenWidth-99)/2, 44);
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font=CUSTOMFONT(16);
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn setBackgroundColor:KCOLOR_Main];
    [self.view addSubview:self.confirmBtn];
 
}

-(void)btnSeletecdClick:(UIButton *)sender{
    for (UIButton *btnView in _buttonArr) {
        
        if (btnView == sender) {
            btnView.selected = YES;
            btnView.layer.borderColor=KCOLOR_Main.CGColor;
            btnView.backgroundColor = [UIColor whiteColor];
        
        }else{
            btnView.layer.borderColor=UIColorFromRGB(0xdedede).CGColor;
            btnView.backgroundColor = KViewBgColor;
            btnView.selected = NO;
        }
    }
    
}

-(void)confirmBtnClick{
    emptyBlock(self.screeningDataBlock,@"333");
    [self closeView];
}
 

 

-(void)resetBtnClick{
   [[CQSideBarManager sharedInstance] closeSideBar];
}

- (void)closeView
{
    [[CQSideBarManager sharedInstance] closeSideBar];
}
 

@end
