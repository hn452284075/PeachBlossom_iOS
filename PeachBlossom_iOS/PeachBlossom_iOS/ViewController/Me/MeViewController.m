//
//  MeViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "MeViewController.h"
#import "CustomFlowLayout.h"
#import "MeCollectionViewCell.h"
#import "MeHeaderView.h"
#import "AddressMangerController.h"
#import "CollectGoodsVC.h"
#import "CollectStoreVC.h"
#import "ProcurementOrderVC.h"
#import "LoginViewController.h"

@interface MeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)CustomFlowLayout *flowlayout;
@property (nonatomic,strong)MeHeaderView *headerV;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)_init{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];

    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

#pragma mark ------------------------Delegate-----------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    MeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeCollectionViewCell" forIndexPath:indexPath];
    WEAK_SELF
    cell.indexBlock = ^(NSInteger index) {
        [weak_self jumoIndexPage:index];
    };
        
    return cell;
   
}





//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
 
    if (kind == UICollectionElementKindSectionHeader) {
        
        self.headerV  = (MeHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MeHeaderView" forIndexPath:indexPath];
        WEAK_SELF
        //登录
        [self.headerV.loginBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self jumoIndexPage:5];
        }];
        
        //收藏产品
        [self.headerV.goodsBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self jumoIndexPage:6];
        }];
        //收藏店铺
        [self.headerV.storeBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self jumoIndexPage:7];
        }];
        //浏览记录
        [self.headerV.recordBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           [weak_self jumoIndexPage:8];
        }];
        //认证
        [self.headerV.certificationBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           [weak_self jumoIndexPage:9];
        }];
        
        
    }
    
    return self.headerV;
    
}

#pragma mark ------------------------Page Navigate------------------------
-(void)jumoIndexPage:(NSInteger)index{
    
    switch (index) {
        case 5://登录
        {
            LoginViewController *vc = [[LoginViewController alloc]init];
            vc.pageTitle = nil;
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
//            [self navigatePushViewController:vc animate:YES];

        }
            break;
        case 6://收藏产品
            {
                CollectGoodsVC *vc = [[CollectGoodsVC alloc]init];
                vc.pageTitle=@"关注商品";
                [self navigatePushViewController:vc animate:YES];

            }
            break;
            
        case 7://收藏店铺
            {
                CollectStoreVC *vc = [[CollectStoreVC alloc]init];
                [self navigatePushViewController:vc animate:YES];

            }
            break;
            
        case 8://浏览记录
            {
                CollectGoodsVC *vc = [[CollectGoodsVC alloc]init];
                vc.pageTitle=@"浏览记录";
                [self navigatePushViewController:vc animate:YES];
            }
            break;
            
        case 9://认证
            {
            
            }
            break;
                
        case 10://全部
            {
                ProcurementOrderVC *vc = [[ProcurementOrderVC alloc]init];
                vc.currentIndex=0;
                [self navigatePushViewController:vc animate:YES];

            }
            break;
            
        case 11://待付款
            {
                ProcurementOrderVC *vc = [[ProcurementOrderVC alloc]init];
                vc.currentIndex=1;
                [self navigatePushViewController:vc animate:YES];
            }
            break;
        case 12://待发货
            {
                ProcurementOrderVC *vc = [[ProcurementOrderVC alloc]init];
                vc.currentIndex=2;
                [self navigatePushViewController:vc animate:YES];
            }
            break;
        case 13://待收货
            {
                ProcurementOrderVC *vc = [[ProcurementOrderVC alloc]init];
                vc.currentIndex=3;
                [self navigatePushViewController:vc animate:YES];
           
            }
            break;
        case 14://待评价
            {
                ProcurementOrderVC *vc = [[ProcurementOrderVC alloc]init];
                vc.currentIndex=4;
                [self navigatePushViewController:vc animate:YES];
            }
            break;
        case 15://退款/售后
            {
           
            }
            break;
        case 16://收货地址
            {
                AddressMangerController *vc = [[AddressMangerController alloc]init];
                [self navigatePushViewController:vc animate:YES];
            }
            break;
        case 17://银行卡
            {
           
            }
            break;
        case 18://我的桃币
            {
           
            }
            break;
            
        default:
            break;
    }
    
}

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _flowlayout = [[CustomFlowLayout alloc] init];
       
        [_flowlayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, 247)];
        _flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0);
        _flowlayout.minimumInteritemSpacing = 0;
        _flowlayout.minimumLineSpacing = 0;
        _flowlayout.itemSize = CGSizeMake(kScreenWidth,230);
        _collectionView.alwaysBounceVertical = YES;
        //设置滚动方向
        [_flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndTabBarHeight)  collectionViewLayout:_flowlayout];
        _collectionView.backgroundColor = KViewBgColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"MeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MeCollectionViewCell"];
 
        //注册头
        [_collectionView registerNib:[UINib nibWithNibName:@"MeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MeHeaderView"];
    }
    return _collectionView;
}

@end
