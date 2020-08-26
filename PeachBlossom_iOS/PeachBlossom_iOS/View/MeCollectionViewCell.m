//
//  MeCollectionViewCell.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "MeCollectionViewCell.h"

@implementation MeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnClickIndex:(UIButton *)sender{
    emptyBlock(self.indexBlock,sender.tag);
}

@end
