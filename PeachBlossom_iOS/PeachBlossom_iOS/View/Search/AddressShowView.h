//
//  AddressShowView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/24.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCell.h"
#import "MyCommonCollectionView.h"
#import "AddressCell.h"
#import "EWAddressModel.h"
#import "AddressHeaderView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SeletecdAddressBlock)(NSString *str);
@interface AddressShowView : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>
+ (instancetype)addressManager;
@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,strong) EWCountryModel *locationModel;
@property (nonatomic,strong) EWProvinceModel *provincesModel;
@property (nonatomic,strong) EWCityModel *cityModel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSMutableArray *areaArray;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSString *provinceStr;
@property (nonatomic,strong) NSString *cityStr;
@property (nonatomic,copy)SeletecdAddressBlock addressBlock;
-(void)show:(SeletecdAddressBlock)block;
@end

NS_ASSUME_NONNULL_END
