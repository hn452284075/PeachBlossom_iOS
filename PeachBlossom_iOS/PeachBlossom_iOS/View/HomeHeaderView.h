//
//  HomeHeaderView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef void(^SeletecdIndexBlock)(NSInteger index);


@interface HomeHeaderView : UICollectionReusableView<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headCycleView;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,copy)SeletecdIndexBlock seletecdIndexBlock;

@end

