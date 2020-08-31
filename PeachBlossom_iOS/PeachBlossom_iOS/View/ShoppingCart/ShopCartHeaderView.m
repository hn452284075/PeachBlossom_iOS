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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
