//
//  AddressCell.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/18.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)deleteBtnClick:(id)sender {
    emptyBlock(self.deleteBlock);
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    // 获得每个cell的属性集
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    // 计算cell里面textfield的宽度
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 26) options:(NSStringDrawingTruncatesLastVisibleLine|   NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    // 这里在本身宽度的基础上 又增加了10
    frame.size.width += 25;
    frame.size.height = 26;

    // 重新赋值给属性集
    attributes.frame = frame;
    
    return attributes;
}
@end


 
