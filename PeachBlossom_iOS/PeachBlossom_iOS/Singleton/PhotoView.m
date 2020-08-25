//
//  PhotoView.m
//  BloodSugar-Patient
//
//  Created by 曾勇兵 on 2020/7/9.
//  Copyright © 2020 wangyan. All rights reserved.
//

#import "PhotoView.h"
#import "UIView+BlockGesture.h"
static PhotoView *_photoManager = nil;
@implementation PhotoView
+ (instancetype)photoManager{
    static dispatch_once_t onceToken;
       
       dispatch_once(&onceToken, ^{
           
           _photoManager = [[PhotoView alloc] init];
           
       });
       
       return _photoManager;
}
- (void)seletecdIndexBlock:(SeletecdIndexBlock)seletecdIndexBlock{
    

     _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _viewBG.tag=777;
    _viewBG.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_viewBG];
    WEAK_SELF
    [_viewBG addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self colse];
    }];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 217.5f)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.tag=999;
    self.bottomView.layer.cornerRadius=10;
       //UIView设置阴影UIColorFromRGB(0xacacac).CGColor;
    self.bottomView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.bottomView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bottomView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.bottomView.layer.shadowRadius = 5;//阴影半径，默认3
    self.bottomView.layer.masksToBounds = NO;
    [_viewBG addSubview:self.bottomView];
    
    UIButton *shootingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shootingBtn.frame = CGRectMake(0, 28, kScreenWidth, 30);
    shootingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shootingBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [shootingBtn setTitle:@"拍摄照片" forState:UIControlStateNormal];
    [shootingBtn addTarget:self action:@selector(shootingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:shootingBtn];
    
    UIButton *seletecdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    seletecdBtn.frame = CGRectMake(0,78, kScreenWidth, 30);
    seletecdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [seletecdBtn setTitle:@"选择手机中的图片" forState:UIControlStateNormal];
    [seletecdBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [seletecdBtn addTarget:self action:@selector(seletecdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:seletecdBtn];
    
      UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      cancelBtn.frame = CGRectMake(kScreenWidth/2-350/2,143, 350, 40);
      cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
      [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
      [cancelBtn setBackgroundColor:UIColorFromRGB(0xDCDCDC)];
    cancelBtn.layer.cornerRadius=20;
    [cancelBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
      [cancelBtn addTarget:self action:@selector(cancelBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
      [_bottomView addSubview:cancelBtn];
    
    
    [UIView animateWithDuration:0.3 animations:^{
           
           weak_self.bottomView.frame = CGRectMake(0, kScreenHeight-217.5f, kScreenWidth, 217.5f);
           
           
    } completion:^(BOOL finished) {
       
       
    }];
    
    self.seletecdIndexBlock =seletecdIndexBlock;
}


-(void)shootingBtnClick{
    
    emptyBlock(self.seletecdIndexBlock,1);
    [self colse];
}

- (void)seletecdBtnClick{
    
    emptyBlock(self.seletecdIndexBlock,2);
    [self colse];
}

-(void)cancelBtnBtnClick{
    emptyBlock(self.seletecdIndexBlock,0);
    [self colse];
}



- (void)colse{
    WEAK_SELF
 [UIView animateWithDuration:0.3 animations:^{
     
     weak_self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 145);
     

 } completion:^(BOOL finished) {
      [[[UIApplication sharedApplication].keyWindow viewWithTag:777] removeFromSuperview];
 }];
     
}


@end
