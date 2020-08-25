//
//  SearchViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/18.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchViewController.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "SearchListVC.h"
#import "MycommonTableView.h"
#import "SearchCell.h"
#import "MyCommonCollectionView.h"
#import "AddressCell.h"
#import "EWAddressModel.h"
#import "AddressHeaderView.h"
#import "AddressShowView.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@property (nonatomic,strong)MycommonTableView *listTableView;
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

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLocationData];
   
    [self.view addSubview:self.listTableView];
    
    self.titleArr=@[@"省份选择"];
    [_listTableView configureTableAfterRequestPagingData:@[@"",@"",@"",@"",@"",@""]];
 
           
}


#pragma mark ------------------------Init---------------------------------
 
- (void)initLocationData{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    self.locationModel = [[EWCountryModel alloc]initWithDic:dic];
    self.dataArray = [[NSMutableArray alloc]initWithArray:_locationModel.provincesArray];
    [self.dataArray insertObject:@"全部" atIndex:0];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}




#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)regionClick:(id)sender{

    [[AddressShowView addressManager]show:^(NSString * _Nonnull str) {
        NSLog(@"%@",str);
    }];
}

- (IBAction)goBackClick:(id)sender{
    [self goBack];
}

#pragma mark ------------------------Delegate-----------------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0,133,kScreenWidth, kScreenHeight-133) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.noDataLogicModule.nodataAlertTitle=@"暂无血糖测量方案";
        _listTableView.noDataLogicModule.nodataAlertImage=@"pic-default-01"; _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 163.0f;
        
        [_listTableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
        WEAK_SELF
        [_listTableView configurecellNibName:@"SearchCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            SearchListVC *vc = [[SearchListVC alloc]init];
            [self  navigatePushViewController:vc animate:YES];
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
          
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
           
            
        }];
        
        
        
    }
    
    return _listTableView;
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
            weak_self.cityArray=@[].mutableCopy;
            weak_self.provinceStr=@"";
            weak_self.cityStr=@"";
            weak_self.areaArray=@[].mutableCopy;
            weak_self.titleArr=@[@"省份选择"];
            
        }else if (indexPath.section==1){
            weak_self.areaArray=@[].mutableCopy;
             weak_self.cityStr=@"";
             weak_self.titleArr=@[@"省份选择",@"城市选择"];
        }else{
            
        }
     
       [weak_self.collectionView reloadData];
    };
    
    
 
    
    if (!isEmpty(_cityArray)) {
        if (!isEmpty(_areaArray)) {
            
          if (indexPath.section==0) {
               cell.titleLabel.text=_provinceStr;
               cell.delBtn.hidden = NO;
           }else if (indexPath.section==1) {
               cell.titleLabel.text=_cityStr;
               cell.delBtn.hidden = NO;
           }else{
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(0, 10, 0,10);
    self.flowlayout.minimumInteritemSpacing = 10;
    self.flowlayout.minimumLineSpacing = 10;
             
             
    return CGSizeMake((kScreenWidth-3*10-30)/4, 36);
    
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth,50);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EWProvinceModel *provincesModel2;
    if (indexPath.row==0) {
        return;
    }
    if (isEmpty(_cityArray)) {
        
    
    _provinceStr =_locationModel.provincesArray[indexPath.row-1];
     
    provincesModel2 = _locationModel.countryDictionary[_provinceStr];
    
    self.provincesModel = provincesModel2;
    }
    if (!isEmpty(self.areaArray)) {
        NSLog(@"%@",self.areaArray[indexPath.row]);
        
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

#pragma mark ------------------------Getter / Setter----------------------
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
    
        self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        //设置滚动方向
        [self.flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView = [[MyCommonCollectionView alloc] initWithFrame:CGRectMake(0, 130, kScreenWidth, kScreenHeight-130)  collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
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
@end
