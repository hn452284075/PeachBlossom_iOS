//
//  SearchGoodsCell.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchGoodsCell.h"

@implementation SearchGoodsCell
- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.font = [UIFont systemFontOfSize:14];
        _content.textAlignment = 1;
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _content.textColor =UIColorFromRGB(0x666666);
        self.layer.cornerRadius = 13;
        
    }
    return _content;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.content];
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

 @end
