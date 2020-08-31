//
//  CategoryShowView.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CategoryShowView.h"
#import "UIView+Frame.h"
#import "UIView+BlockGesture.h"
@implementation CategoryShowView

-(instancetype)initWithCategoryShowViewFrame:(CGRect)frame AndDataSource:(NSArray*)arr{
    
     self = [super initWithFrame:frame];
      if (self) {
          _array=arr;
          [self initUI];
          
        }
        
        return self;
        
    
}

-(void)initUI{
 
        _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, self.height)];
        _viewBG.tag=222;
        
        _viewBG.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.5];
        [self addSubview:_viewBG];
        [_viewBG addSubview:self.collectionView];
        
    
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,330, kScreenWidth,kScreenHeight-self.height-kStatusBarAndNavigationBarHeight)];
        
        WEAK_SELF
        [bottomView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            emptyBlock(weak_self.seletecdTypeBlock,@"");
            [weak_self colse];
        }];
        [_viewBG addSubview:bottomView];
    
        [UIView animateWithDuration:0.2 animations:^{
                   
             weak_self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 330);
              
                   
            } completion:^(BOOL finished) {
               
               
        }];
}

- (void)colse{
    
//    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
//
//    _addressShowView = nil;
//
//    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
     
    
     
    self.viewBG.backgroundColor=[UIColor clearColor];
    WEAK_SELF
     [UIView animateWithDuration:0.3 animations:^{
         
        weak_self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 0);
         

     } completion:^(BOOL finished) {
          [self removeFromSuperview];
     }];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(17, 10, 0,10);
    self.flowlayout.minimumInteritemSpacing = 10;
    self.flowlayout.minimumLineSpacing = 10;
             
             
    return CGSizeMake((kScreenWidth-2*10-20)/3, 36);
    
    
}

//设置容器中有多少个组
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddressCell" forIndexPath:indexPath];
    //默认选中每组的第一个
    if (indexPath.row==0) {
        cell.titleLabel.layer.borderWidth=0.5;
        cell.titleLabel.backgroundColor=[UIColor whiteColor];
        cell.titleLabel.layer.borderColor=KCOLOR_Main.CGColor;
        cell.titleLabel.textColor=KCOLOR_Main;
    }else{
        cell.titleLabel.backgroundColor=UIColorFromRGB(0xf2f2f2);
        cell.titleLabel.layer.borderColor=[UIColor clearColor].CGColor;
        cell.titleLabel.textColor=UIColorFromRGB(0x666666);
    }
    cell.titleLabel.text = self.array[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    emptyBlock(self.seletecdTypeBlock,self.array[indexPath.row]);
    [self colse];
    
}
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
      

        self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
 
        //设置滚动方向
        [self.flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)  collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellWithReuseIdentifier:@"AddressCell"];
    
        
    }
    return _collectionView;
}

@end
