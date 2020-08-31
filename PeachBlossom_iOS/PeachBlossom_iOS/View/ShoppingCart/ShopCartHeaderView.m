//
//  ShopCartHeaderView.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/25.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ShopCartHeaderView.h"
#import "StoreModel.h"
@implementation ShopCartHeaderView
-(void)awakeFromNib{
    [super awakeFromNib];
    //创建 layer
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
       maskLayer.frame = self.bgView.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: maskLayer.frame = self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    maskLayer.frame = self.bgView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
}
- (IBAction)seletedClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    emptyBlock(self.headerViewBlock,self.tag,sender.selected);
    
}

- (void)setModel:(StoreModel *)model {
    
    self.storeName.text = model.storeTitle;
    if (model.isChecked) {
      
        _seletedBtn.selected = YES;
        
    }else{
        _seletedBtn.selected = NO;
    }

}
@end
