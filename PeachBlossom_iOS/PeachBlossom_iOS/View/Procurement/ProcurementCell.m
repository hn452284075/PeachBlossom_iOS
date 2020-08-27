//
//  ProcurementCell.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ProcurementCell.h"

@implementation ProcurementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setButtonArr:(NSArray *)buttonArr{

         
    
    // 保存前一个button的宽以及前一个button距离屏幕边缘的距
    CGFloat edge =10;
    //设置button 距离父视图的高
    
    self.buttonX.constant = kScreenWidth-buttonArr.count*69-50.5-((buttonArr.count-1)*edge);
 
    for (int i =0; i< buttonArr.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
        button.tag =200+i;
        button.backgroundColor =[UIColor whiteColor];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.cornerRadius = 13;
        button.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        button.layer.borderWidth = 0.5f;
       
        //确定文字的字号
        button.titleLabel.font = [UIFont systemFontOfSize:12];

        CGFloat length = 69;
        //为button赋值
        [button setTitle:[self findStatusKey:buttonArr[i]] forState:(UIControlStateNormal)];
        if ([button.titleLabel.text isEqualToString:@"支付"]) {
              [button setTitleColor:UIColorFromRGB(0xff3f3f)  forState:(UIControlStateNormal)];
        }else{

            [button setTitleColor:UIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
        }
        //设置button的frame
        button.frame =CGRectMake(edge, 13, length, 26);
        
 
        //获取前一个button的尾部位置位置
        edge = button.frame.size.width +button.frame.origin.x+edge;
        
        [self.bottomView addSubview:button];
        
        
    }

}

 
- (void)selectClick:(UIButton *)btn{

    
    emptyBlock(self.buttonTitleBlock,btn.titleLabel.text);
    
}

- (NSString *)findStatusKey:(NSString *)key{

    NSDictionary *dic = @{@"confirm":@"确认收货",@"pay":@"支付",@"details":@"查看详情",@"cancel_order":@"取消订单",@"delete":@"删除订单",@"delivery":@"待发货",@"again":@"再次购买",@"feedback":@"评价",@"logistics":@"物流",@"remindDelivery":@"提醒发货"};

    return dic[key];
    
}

-(void)setDic:(NSDictionary *)dic{
    
   
//    self.priceTotal.text =[NSString stringWithFormat:@"￥%@",dic[@"totalAmount"]];
//    self.titleLabel.text = dic[@"productName"];
//    self.orderPrice.text =[NSString stringWithFormat:@"%@",dic[@"productAmount"]];
//    self.contentLabel.text =[NSString stringWithFormat:@"%@",dic[@"productTitle"]];
    NSString *str;
    self.orderStatus.textColor = UIColorFromRGB(0xff3f3f);
    if ([dic[@"status"]intValue]==1) {
        str = @"待付款";
        [self setButtonArr:@[@"details",@"pay"]];
    }else if([dic[@"status"]intValue]==2) {
        str = @"待发货";
        [self setButtonArr:@[@"details"]];
    }else if([dic[@"status"]intValue]==3) {
        str = @"交易成功";
        [self setButtonArr:@[@"delete",@"again"]];
        self.orderStatus.textColor = UIColorFromRGB(0x999999);
    }else if([dic[@"status"]intValue]==4) {
        str = @"关闭交易";
        [self setButtonArr:@[@"delete",@"again"]];
        self.orderStatus.textColor = UIColorFromRGB(0x999999);
    }else{
        [self setButtonArr:@[@"confirm",@"details"]];
        str = @"发货成功";
        
    }
    
    self.orderStatus.text =str;
//    [self.orderImage sd_SetImgWithUrlStr:[NSString stringWithFormat:@"%@%@",KImageHost,dic[@"productPic"]] placeHolderImgName:nil];
    
    
}
@end
