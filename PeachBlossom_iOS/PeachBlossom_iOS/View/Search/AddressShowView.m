//
//  AddressShowView.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/24.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AddressShowView.h"
#import "UIView+BlockGesture.h"
@implementation AddressShowView
-(instancetype)initWithAddresFrame:(CGRect)frame {
     self = [super initWithFrame:frame];
      if (self) {
        
          [self initUI];
             
        }
        
        return self;
    
}

-(void)initUI{
        
       _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, self.height)];
       _viewBG.tag=222;
       _viewBG.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.5];
       [self addSubview:_viewBG];
    
       self.titleArr=@[@"省份选择"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
       self.locationModel = [[EWCountryModel alloc]initWithDic:dic];
       self.dataArray = [[NSMutableArray alloc]initWithArray:_locationModel.provincesArray];
       [self.dataArray insertObject:@"全部" atIndex:0];
       
       [_viewBG addSubview:self.collectionView];
       
       self.resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       self.resetBtn.frame = CGRectMake(0,self.height-130-50, kScreenWidth/2, 50);
       [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
       self.resetBtn.titleLabel.font=CUSTOMFONT(16);
       [self.resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [self.resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [self.resetBtn setBackgroundColor:KTextColor];
       self.resetBtn.hidden=YES;
       [_viewBG addSubview:self.resetBtn];
       
       self.confirmBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
       self.confirmBtn.frame = CGRectMake(kScreenWidth/2,self.height-130-50, kScreenWidth/2, 50);
       [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
       self.confirmBtn.titleLabel.font=CUSTOMFONT(16);
       [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [self.confirmBtn setBackgroundColor:KCOLOR_Main];
       self.confirmBtn.hidden=YES;
       [_viewBG addSubview:self.confirmBtn];
    
       
       UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,self.confirmBtn.bottom, kScreenWidth, self.height-self.confirmBtn.bottom)];
       WEAK_SELF
       [bottomView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           emptyBlock(weak_self.addressBlock,@"");
           [weak_self colse];
       }];
       [_viewBG addSubview:bottomView];
         
        
       [UIView animateWithDuration:0.2 animations:^{
                
         weak_self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.height-130-50);
           
                
         } completion:^(BOOL finished) {
            
            weak_self.resetBtn.hidden=NO;
            weak_self.confirmBtn.hidden=NO;
         }];
    
}
 


-(void)confirmBtnClick{
    if (isEmpty(_areaStr)) {
        return;
    }
    
    emptyBlock(self.addressBlock,[NSString stringWithFormat:@"%@%@%@",self.provinceStr,self.cityStr,self.areaStr]);
    [self colse];
}
 

 

-(void)resetBtnClick{
   [self resetData];
   [self.collectionView reloadData];
}



- (void)colse{
    
//    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
//
//    _addressShowView = nil;
//
//    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
     
    
    self.resetBtn.hidden=YES;
    self.confirmBtn.hidden=YES;
    self.viewBG.backgroundColor=[UIColor clearColor];
    WEAK_SELF
     [UIView animateWithDuration:0.3 animations:^{
         
        weak_self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 0);
         

     } completion:^(BOOL finished) {
          [self removeFromSuperview];
     }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (!isEmpty(self.provinceStr)) {
        
      if (!isEmpty(self.cityStr)) {
            if (section==2) {
              return self.areaArray.count;
            }else{
                return 1;
            }

      }else{
        
          if (section==0) {
            return 1;
          }else{
            return self.cityArray.count;
          }
      }
        
    }
     
    return self.dataArray.count;
    
}

//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return self.titleArr.count;
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        AddressHeaderView *headerV  = (AddressHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddressHeaderView" forIndexPath:indexPath];
        headerV.titleLabel.text = self.titleArr[indexPath.section];
        
        return headerV;
    }
    return nil;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddressCell" forIndexPath:indexPath];
    WEAK_SELF
    
    cell.deleteBlock = ^{
        if (indexPath.section==0) {
            [weak_self resetData];
            
        }else if (indexPath.section==1){
            weak_self.areaArray=@[].mutableCopy;
             weak_self.cityStr=@"";
             weak_self.titleArr=@[@"省份选择",@"城市选择"];
        }else{
            
        }
     
       [weak_self.collectionView reloadData];
    };
    
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
    
  
    
    if (!isEmpty(_cityArray)) {
        if (!isEmpty(_areaArray)) {
            
          if (indexPath.section==0) {
               cell.titleLabel.text=_provinceStr;
               cell.delBtn.hidden = NO;

           }else if (indexPath.section==1) {
               cell.titleLabel.text=_cityStr;
               cell.delBtn.hidden = NO;
           }else{
//               if (indexPath.section==2) {
                 if (_currentIndex==indexPath.row) {
                     cell.titleLabel.layer.borderWidth=0.5;
                     cell.titleLabel.backgroundColor=[UIColor whiteColor];
                     cell.titleLabel.layer.borderColor=KCOLOR_Main.CGColor;
                     cell.titleLabel.textColor=KCOLOR_Main;
                 }else{
                    
                     cell.titleLabel.backgroundColor=UIColorFromRGB(0xf2f2f2);
                     cell.titleLabel.layer.borderColor=[UIColor clearColor].CGColor;
                     cell.titleLabel.textColor=UIColorFromRGB(0x666666);
                 }
                 
//             }
               cell.delBtn.hidden = YES;
               cell.titleLabel.text = self.areaArray[indexPath.row];

           }
            return cell;
        }else{
            if (indexPath.section==0) {
                    cell.titleLabel.text=_provinceStr;
                    cell.delBtn.hidden = NO;
 
            }else{
                    cell.delBtn.hidden = YES;
                    cell.titleLabel.text = self.cityArray[indexPath.row];
 
            }
            return cell;
        }
    }
    
    cell.delBtn.hidden = YES;
    cell.titleLabel.text = self.dataArray[indexPath.row];
                    
    return cell;
        
     
}

-(void)resetData {
    
   self.cityArray=@[].mutableCopy;
   self.provinceStr=@"";
   self.cityStr=@"";
   self.areaArray=@[].mutableCopy;
   self.titleArr=@[@"省份选择"];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(0, 10, 0,10);
    self.flowlayout.minimumInteritemSpacing = 10;
    self.flowlayout.minimumLineSpacing = 10;
             
             
    return CGSizeMake((kScreenWidth-3*10-30)/4, 36);
    
    
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
        _collectionView.tag=200;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellWithReuseIdentifier:@"AddressCell"];
    
        //注册头
        [_collectionView registerNib:[UINib nibWithNibName:@"AddressHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddressHeaderView"];
    }
    return _collectionView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth,50);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EWProvinceModel *provincesModel2;
    if (indexPath.row==0&&indexPath.section!=2) {
        return;
    }
    if (isEmpty(_cityArray)) {
        
    
    _provinceStr =_locationModel.provincesArray[indexPath.row-1];
     
    provincesModel2 = _locationModel.countryDictionary[_provinceStr];
    
    self.provincesModel = provincesModel2;
    }
    if (!isEmpty(self.areaArray)) {
        NSLog(@"%@",self.areaArray[indexPath.row]);
//        emptyBlock(self.addressBlock,self.areaArray[indexPath.row]);
//        [self colse];
        self.areaStr =self.areaArray[indexPath.row];
        if (_currentIndex !=indexPath.row) {
            _currentIndex=indexPath.row;
            [self.collectionView reloadData];
        }
        return;
    }
    if (!isEmpty(_cityArray)) {
        _cityStr = _cityArray[indexPath.row];
           EWCityModel *cityModel = self.provincesModel.provincesDictionary[_cityStr];
        self.areaArray=[[NSMutableArray alloc]initWithArray:cityModel.areaArray];
//        NSLog(@"www%@",cityModel.areaArray[0]);
        [self.areaArray insertObject:@"全部" atIndex:0];
        
        _titleArr=@[@"省份选择",@"城市选择",@"地区选择"];
        
    }else{
        self.cityArray = [[NSMutableArray alloc]initWithArray:provincesModel2.cityArray];
        [self.cityArray insertObject:@"全部" atIndex:0];
        _titleArr=@[@"省份选择",@"城市选择"];
    }
   
    
    [self.collectionView reloadData];
}

 

@end
