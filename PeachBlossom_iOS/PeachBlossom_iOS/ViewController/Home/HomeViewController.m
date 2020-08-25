//
//  HomeViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "HomeViewController.h"
#import "MyCommonCollectionView.h"
#import "HomeAllCollectionCell.h"
#import "AddressCell.h"
#import "HomeHeaderView.h"
#import "SearchViewController.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)MyCommonCollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)HomeHeaderView *headerV;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
 
    [self _initTop];
    [self _initCollection];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark ------------------------Init---------------------------------
-(void)_initTop{
    self.topView= [[UIView alloc] init];
    self.topView.backgroundColor = KCOLOR_Main;
    [self.view addSubview:self.topView];
  
  
    UIView *seachView = [[UIView alloc] init];
    seachView.backgroundColor = [UIColor whiteColor];
    seachView.layer.cornerRadius=15;
    WEAK_SELF
    [seachView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self jumpSeachPage];
    }];
    [self.topView addSubview:seachView];
    
    UIButton *cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartBtn addTarget:self action:@selector(cartClick) forControlEvents:UIControlEventTouchUpInside];
    [cartBtn setImage:IMAGE(@"home-care") forState:UIControlStateNormal];
    [self.topView addSubview:cartBtn];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:IMAGE(@"home-seacher") forState:UIControlStateNormal];
    [seachBtn setTitle:@"请输入商品" forState:UIControlStateNormal];
    [seachBtn setTitleColor:KTextColor forState:UIControlStateNormal];
    [seachBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    seachBtn.titleLabel.font= CUSTOMFONT(12);
    [seachView addSubview:seachBtn];
    
    
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
             
         make.top.width.left.mas_equalTo(weak_self.view);
         make.height.mas_equalTo(66);
      
             
    }];
    
    [seachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(29);
        make.width.mas_equalTo(kScreenWidth-56);
        make.left.mas_equalTo(weak_self.view).offset(15);
        make.height.mas_equalTo(30);
        
    }];
    
    [seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(13.5);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(seachView);
        make.right.mas_equalTo(weak_self.topView.mas_right).offset(-13);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
}
- (void)_initCollection {
    
    [self.view addSubview:self.collectionView];
 
    WEAK_SELF
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weak_self.topView.mas_bottom);
        make.width.left.mas_equalTo(weak_self.view);
        make.height.mas_equalTo(kScreenHeight-kStatusBarAndTabBarHeight-66);
 
        
    }];
    
}
#pragma mark ------------------------Delegate-----------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 6;
    
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
        //定制头部视图的内容
        if (kind == UICollectionElementKindSectionHeader) {
            
            self.headerV  = (HomeHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderView" forIndexPath:indexPath];
            [self.headerV setArray:@[]];
          
            
            return self.headerV;
        }
 
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeAllCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeAllCollectionCell" forIndexPath:indexPath];
     


    return cell;
        
     
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
       self.flowlayout.sectionInset = UIEdgeInsetsMake(10, 16, 12,16);
       self.flowlayout.minimumInteritemSpacing = 16;
       self.flowlayout.minimumLineSpacing = 16;
               
       CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:0 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:90 edgeBetweenCellAndCell:16 edgeBetweenCellAndSide:16];
       CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    
        return CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
}

#pragma mark ------------------------Getter / Setter----------------------
- (MyCommonCollectionView *)collectionView
{
    if (!_collectionView)
    {
      

        self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        [self.flowlayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, kScreenWidth/2.5+330)];
         
        
        //设置滚动方向
        [self.flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView = [[MyCommonCollectionView alloc] initWithFrame:CGRectZero  collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:UIColorFromRGB(0xF7F7F7)];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeAllCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeAllCollectionCell"];
        WEAK_SELF
        [_collectionView headerRreshRequestBlock:^{
            
        }];
        
        [_collectionView footerRreshRequestBlock:^{
         
        }];
        
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeAllTabCell" bundle:nil] forCellWithReuseIdentifier:@"HomeAllTabCell"];
        
//        //注册头
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderView"];
    }
    return _collectionView;
}

#pragma mark ------------------------Api----------------------------------


#pragma mark ------------------------Page Navigate------------------------
-(void)jumpSeachPage{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self navigatePushViewController:vc animate:YES];
}
-(void)cartClick{
    
  
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
