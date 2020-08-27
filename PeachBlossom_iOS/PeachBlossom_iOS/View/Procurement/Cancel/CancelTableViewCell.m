//
//  CancelTableViewCell.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CancelTableViewCell.h"

@implementation CancelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}
- (void)createSubView{
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = UIColorFromRGB(0x666666);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self);
    }];
    

    _stateView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cancelDefault"]];
    [self.contentView addSubview:_stateView];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
}

@end
