//
//  WaitingPayDetailsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "WaitingPayDetailsVC.h"
#import "HomeAllCollectionCell.h"
#import "WaitingPayTabCell.h"
#import "WaitingPayAddressView.h"
#import "WaitingPayTotalView.h"
#import "WaitingPayTabCell.h"
#import "WaitingPayInfoView.h"
#import "HomeAllCollectionCell.h"
#import "CellCalculateModel.h"
#import "CancelPopView.h"
@interface WaitingPayDetailsVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *detailsCollecView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,strong)WaitingPayAddressView *addressHeaderView;//地址头部
@property (nonatomic,strong)WaitingPayInfoView *infoHeaderView;//支付信息头部
@property (nonatomic,strong)WaitingPayTotalView *totalFooterView;//商品下面的总价尾部

@end

@implementation WaitingPayDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initCollection];
}
 
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark ------------------------Init---------------------------------
- (void)_initCollection {
    
    [self.view addSubview:self.detailsCollecView];
 
     
    WEAK_SELF
    [self.detailsCollecView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.left.mas_equalTo(weak_self.view);
        make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(-52);
        
    }];
    if (@available(iOS 11.0, *)) {
        self.detailsCollecView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     [self setButtonArr:@[@"pay"]];
    
}
#pragma mark ------------------------Private------------------------------
- (void)setButtonArr:(NSArray *)buttonArr{//后面有时间再去封装

    // 保存前一个button的宽以及前一个button距离屏幕边缘的距
    CGFloat edge =10;
    //设置button 距离父视图的高
    
    self.bottomX.constant = kScreenWidth-buttonArr.count*69-30-((buttonArr.count-1)*edge);
 
    for (int i =0; i< buttonArr.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
        button.tag =200+i;
        button.backgroundColor =[UIColor whiteColor];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.cornerRadius = 13;
        button.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        button.layer.borderWidth = 0.5f;
       
        //确定文字的字号
        button.titleLabel.font = [UIFont systemFontOfSize:12];

        CGFloat length = 69;
        //为button赋值
        [button setTitle:[self findStatusKey:buttonArr[i]] forState:(UIControlStateNormal)];
        if ([button.titleLabel.text isEqualToString:@"支付"]) {
              [button setTitleColor:UIColorFromRGB(0xff3f3f)  forState:(UIControlStateNormal)];
        }else{

            [button setTitleColor:UIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
        }
        //设置button的frame
        button.frame =CGRectMake(edge, 13, length, 26);
        
 
        //获取前一个button的尾部位置位置
        edge = button.frame.size.width +button.frame.origin.x+edge;
        
        [self.bottomView addSubview:button];
        
        
    }

}

-(void)selectClick:(UIButton *)btn{
    [[CancelPopView sharedInstance]show:^(NSString *type) {
        NSLog(@"%@",type);
    }];
    
}

- (NSString *)findStatusKey:(NSString *)key{

    NSDictionary *dic = @{@"confirm":@"确认收货",@"pay":@"支付",@"details":@"查看详情",@"cancel_order":@"取消订单",@"delete":@"删除订单",@"delivery":@"待发货",@"again":@"再次购买",@"feedback":@"评价",@"logistics":@"物流",@"remindDelivery":@"提醒发货"};

    return dic[key];
    
}



#pragma mark ------------------------Delegate-----------------------------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        WaitingPayTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaitingPayTabCell" forIndexPath:indexPath];
        
          return cell;
    }
    HomeAllCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeAllCollectionCell" forIndexPath:indexPath];
    
      return cell;
  
   
}
//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    

    if (kind == UICollectionElementKindSectionHeader) {
            if (indexPath.section==0) {
                self.addressHeaderView  = (WaitingPayAddressView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WaitingPayAddressView" forIndexPath:indexPath];
                WEAK_SELF
                [self.addressHeaderView.goBackBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                    [weak_self goBack];
                }];
                return self.addressHeaderView;
            }else{
                self.infoHeaderView  = (WaitingPayInfoView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WaitingPayInfoView" forIndexPath:indexPath];
                         
                         
                return self.infoHeaderView;
            }
        
        
    }else{
        
        if (kind == UICollectionElementKindSectionFooter) {
            if (indexPath.section==0) {
               self.totalFooterView  = (WaitingPayTotalView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WaitingPayTotalView" forIndexPath:indexPath];
                         
             return self.totalFooterView;
            
            }else{
                return 0;
            }
        
        }
    
    }
        
 
    return 0;
    
}

//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {//购买产品cell大小
        
        return CGSizeMake(kScreenWidth, 92);
    }
    //底部推荐cell大小
   CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:0 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:90 edgeBetweenCellAndCell:16 edgeBetweenCellAndSide:16];
   CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
  
   return CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);

    
}

//设置单元格的边距。单元格Cell的边距设置，即Cell整体相对于Header、Footer以及屏幕左右两侧的距离，优先级较高；
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==1) {
           UIEdgeInsets insets = UIEdgeInsetsMake(10, 16, 12,16);
           return insets;
    }
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0,0,0);
    return insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 16;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 16;
    }
    return 0;
}
 
// 设置header的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return CGSizeMake(kScreenWidth,313);
    }
    return CGSizeMake(kScreenWidth,313);
}

// 设置Footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
     if(section == 0){
         
         return CGSizeMake(kScreenWidth, 188.5);
     }
        return CGSizeMake(0, 0);
    
}

//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 2;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
        return 4;
}

#pragma mark ------------------------Getter / Setter----------------------

- (UICollectionView *)detailsCollecView
{
    if (!_detailsCollecView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _detailsCollecView.alwaysBounceVertical = YES;
        _detailsCollecView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _detailsCollecView.delegate = self;
        _detailsCollecView.dataSource = self;
        _detailsCollecView.showsVerticalScrollIndicator = NO;
        _detailsCollecView.showsHorizontalScrollIndicator = NO;
        [_detailsCollecView setBackgroundColor:KViewBgColor];
        //注册cell
        [_detailsCollecView registerNib:[UINib nibWithNibName:@"HomeAllCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeAllCollectionCell"];
     
        //注册cell
        [_detailsCollecView registerNib:[UINib nibWithNibName:@"WaitingPayTabCell" bundle:nil] forCellWithReuseIdentifier:@"WaitingPayTabCell"];
        
        //注册头
        [_detailsCollecView registerNib:[UINib nibWithNibName:@"WaitingPayAddressView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WaitingPayAddressView"];
        //注册头
        [_detailsCollecView registerNib:[UINib nibWithNibName:@"WaitingPayInfoView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WaitingPayInfoView"];
        //注册尾部
        [_detailsCollecView registerNib:[UINib nibWithNibName:@"WaitingPayTotalView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WaitingPayTotalView"];
    }
    return _detailsCollecView;
}
@end
