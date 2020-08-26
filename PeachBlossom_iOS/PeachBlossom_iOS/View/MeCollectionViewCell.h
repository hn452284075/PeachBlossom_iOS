//
//  MeCollectionViewCell.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IndexBlock)(NSInteger index);
@interface MeCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy)IndexBlock indexBlock;


@end

