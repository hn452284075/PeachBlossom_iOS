//
//  DeliveryShowView.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "DeliveryShowView.h"
#import "UIView+Frame.h"
#import "UIView+BlockGesture.h"
@implementation DeliveryShowView
-(instancetype)initWithDeliveryFrame:(CGRect)frame {
     self = [super initWithFrame:frame];
      if (self) {
        
          [self initUI];
             
        }
        
        return self;
    
}

-(void)initUI{
        
       _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.width, self.height)];
       _viewBG.tag=222;
       _viewBG.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.5];
        WEAK_SELF
        [_viewBG addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self colse];
        }];
       [self addSubview:_viewBG];
        
    
        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = CGRectMake(0,self.height,self.width,226);
        [_viewBG addSubview:self.bottomView];
        self.bottomView.backgroundColor=[UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,17, 50, 16)];
        titleLabel.textColor = UIColorFromRGB(0x111111);
        titleLabel.textAlignment=0;
        titleLabel.text = @"发货";
        titleLabel.font=CUSTOMFONT(16);
        [_bottomView addSubview:titleLabel];
    
        UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        determineBtn.frame = CGRectMake(kScreenWidth-13-50, 17, 50, 16);
        [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        determineBtn.titleLabel.font=CUSTOMFONT(14);
        [determineBtn setTitleColor:KCOLOR_Main forState:UIControlStateNormal];
        [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:determineBtn];
    
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, 0.5)];
        lineView.backgroundColor = UIColorFromRGB(0xF2F2F2);
        [_bottomView addSubview:lineView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16.5, 92, 60, 17)];
        label.textColor = UIColorFromRGB(0x222222);
        label.textAlignment=1;
        label.text = @"快递公司";
        label.font=CUSTOMFONT(14);
        [_bottomView addSubview:label];
    
    // 创建文本框
        _companyField = [[UITextField alloc] initWithFrame:CGRectMake(97, 86, kScreenWidth-97-14, 25)];
        _companyField.font = [UIFont systemFontOfSize:12];
        _companyField.textColor = KTextColor;
        _companyField.borderStyle = UITextBorderStyleNone;
        _companyField.placeholder = @"请输入快递公司";
        _companyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_bottomView addSubview:_companyField];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(_companyField.left, _companyField.bottom, _companyField.width, 0.5)];
        lineView2.backgroundColor = UIColorFromRGB(0xF2F2F2);
        [_bottomView addSubview:lineView2];
        
    
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(16.5, 156, 60, 17)];
        label2.textColor = UIColorFromRGB(0x222222);
        label2.textAlignment=1;
        label2.text = @"快递单号";
        label2.font=CUSTOMFONT(14);
        [_bottomView addSubview:label2];
    
        _numField = [[UITextField alloc] initWithFrame:CGRectMake(97, 152, kScreenWidth-97-14, 25)];
        _numField.font = [UIFont systemFontOfSize:12];
        _numField.textColor = KTextColor;
        _numField.borderStyle = UITextBorderStyleNone;
        _numField.placeholder = @"请输入快递单号";
        _numField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_bottomView addSubview:_numField];
    
    
          UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(_numField.left, _numField.bottom, _numField.width, 0.5)];
          lineView3.backgroundColor = UIColorFromRGB(0xF2F2F2);
          [_bottomView addSubview:lineView3];
    
        [UIView animateWithDuration:0.2 animations:^{
                   
            weak_self.bottomView.frame = CGRectMake(0,kScreenHeight-226, kScreenWidth, 226);
              
                   
        } completion:^(BOOL finished) {
           
        }];

}

-(void)determineBtnClick{
    if (isEmpty(self.companyField.text)) {
        [[BaseLoadingView sharedManager]showErrorWithStatus:@"请填写快递公司"];
        return;
    }
    if (isEmpty(self.numField.text)) {
        [[BaseLoadingView sharedManager]showErrorWithStatus:@"请填写快递单号"];
        return;
    }
    
    emptyBlock(self.deliveryBlock,self.companyField.text,self.numField.text);
    [self colse];
}
- (void)colse{
    WEAK_SELF
    [UIView animateWithDuration:0.3 animations:^{
            
           weak_self.bottomView.frame = CGRectMake(0, weak_self.height, kScreenWidth, 0);
            

        } completion:^(BOOL finished) {
             [self removeFromSuperview];
        }];
}
@end
