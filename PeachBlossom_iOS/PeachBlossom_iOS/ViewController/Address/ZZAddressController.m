//
//  ZZAddressController.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/20.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ZZAddressController.h"
#import "CityPickView.h"
#import "Util.h"
#import "IQKeyboardManager.h"
@interface ZZAddressController ()
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *region;
@property (nonatomic,strong)NSString *detailAddress;


@end

@implementation ZZAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KViewBgColor;
    self.pageTitle=@"创建收货地址";
//    if (!isEmpty(self.dic)) {//地址编辑进来
//        self.province = _dic[@"province"];
//        self.city = _dic[@"city"];
//        self.region = _dic[@"region"];
//        self.phone.text = _dic[@"phone"];
//        self.userName.text = _dic[@"name"];
//        self.address.text = [NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.region];
//        self.detailsAddress.text = [NSString isEmptyForString:_dic[@"detailAddress"]];
//        self.isDefault.on= [_dic[@"receiveStatus"] intValue];
//    }
    
  
    
    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //写入这个方法后,这个页面将没有这种效果
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //最后还设置回来,不要影响其他页面的效果
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}



#pragma mark ------------------------Init---------------------------------
- (void)_init{

   CityPickView *cityPickView = [[CityPickView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 256)];
   //    cityPickView.address = @"浙江省-杭州市-余杭区";  //设置默认城市，弹出之后显示的是这个
       cityPickView.backgroundColor = [UIColor whiteColor];//设置背景颜色
       cityPickView.toolshidden = NO; //默认是显示的，如不需要，toolsHidden设置为yes
       //每次滚动结束都会返回值
       WEAK_SELF
       cityPickView.confirmblock = ^(NSString *proVince,NSString *city,NSString *area){
           weak_self.address.text = [NSString stringWithFormat:@"%@%@%@",proVince,city,area];
           weak_self.province=proVince;
           weak_self.city=city;
           weak_self.region=area;
       };
       //点击确定按钮回调
       cityPickView.doneBlock = ^(NSString *proVince,NSString *city,NSString *area){
           weak_self.address.text = [NSString stringWithFormat:@"%@%@%@",proVince,city,area];
           weak_self.province=proVince;
                     weak_self.city=city;
                     weak_self.region=area;
           [weak_self.view endEditing:YES];
       };
       //点击取消按钮回调
       cityPickView.cancelblock = ^(){
           [weak_self.view endEditing:YES];
       };
       
       
       
       self.address.inputView = cityPickView;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight-kStatusBarAndNavigationBarHeight-61, kScreenWidth, 61)];
      bottomView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:bottomView];
      
      UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      submitBtn.frame = CGRectMake(15, 10.5, kScreenWidth-30, 40);
      [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
      submitBtn.titleLabel.font=CUSTOMFONT(14);
      submitBtn.layer.cornerRadius=3;
      [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
      [submitBtn setBackgroundColor:KCOLOR_Main];
      [bottomView addSubview:submitBtn];

}
#pragma mark ------------------------Private------------------------------
- (void)_textFieldDidChange:(UITextField *)textField
{
    
    
    if (textField == self.phone) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
#pragma mark ------------------------Api----------------------------------
 
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
 
    
- (void)submitBtnClick {
         [self.userName resignFirstResponder];
         [self.phone resignFirstResponder];
         [self.address resignFirstResponder];
         [self.detailsAddress resignFirstResponder];
         
         if (self.userName.text.length==0) {
            
             [self showSimplyAlertWithTitle:@"提示" message:@"请输入姓名" sureAction:^(UIAlertAction *action) {
                 
             }];
             
         }else if (self.phone.text.length==0) {
             [self showSimplyAlertWithTitle:@"提示" message:@"请输入手机号" sureAction:^(UIAlertAction *action) {
                            
             }];
             
          
             
         }else if (self.address.text.length==0) {
             [self showSimplyAlertWithTitle:@"提示" message:@"请选择地区" sureAction:^(UIAlertAction *action) {
                            
             }];
           
          }else if(self.detailsAddress.text.length==0){
             [self showSimplyAlertWithTitle:@"提示" message:@"请输入详细地址" sureAction:^(UIAlertAction *action) {
                                       
             }];
            
          }else{
              
              if (![Util isValidateMobile:self.phone.text]) {
                  
                  [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误！" sureAction:^(UIAlertAction *action) {
                                                        
                  }];
                  return;
              }
              
           
              
                NSString *isDefaulsStr;
                 if (_isDefault.isOn) {
                     isDefaulsStr = @"1";
                 }else{
                     isDefaulsStr = @"0";
                 }
      
             
          }
             
       
        
           
             
        
}

@end
