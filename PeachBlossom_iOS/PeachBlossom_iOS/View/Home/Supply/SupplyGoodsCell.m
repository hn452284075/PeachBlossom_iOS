//
//  SupplyGoodsCell.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SupplyGoodsCell.h"

@implementation SupplyGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the view for the selected state
}

@end
