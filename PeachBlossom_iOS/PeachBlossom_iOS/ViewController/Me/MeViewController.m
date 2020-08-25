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
   
    
        
    return cell;
   
}





//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
 
    if (kind == UICollectionElementKindSectionHeader) {
        
        self.headerV  = (MeHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MeHeaderView" forIndexPath:indexPath];
//        self.headerV.headerView.layer.cornerRadius = 3;
//        self.headerV.headerView.layer.shadowOffset = CGSizeMake(0, 0);
//        self.headerV.headerView.layer.shadowColor = [UIColor grayColor].CGColor;
//        self.headerV.headerView.layer.shadowOpacity = 0.6;//阴影透明度，默认0
//        self.headerV.headerView.layer.shadowRadius = 6;//阴影半径，默认3
//        self.headerV.headerView.layer.masksToBounds = NO;
        
       
        
        
        
    }
    
    return self.headerV;
    
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
