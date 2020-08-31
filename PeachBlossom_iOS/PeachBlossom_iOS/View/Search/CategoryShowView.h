//
//  CategoryShowView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCell.h"
typedef void(^SeletecdTypeBlock)(NSString * _Nullable str);
NS_ASSUME_NONNULL_BEGIN

@interface CategoryShowView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,copy)SeletecdTypeBlock seletecdTypeBlock;
-(instancetype)initWithCategoryShowViewFrame:(CGRect)frame AndDataSource:(NSArray*)arr;
- (void)colse;
@end

NS_ASSUME_NONNULL_END
