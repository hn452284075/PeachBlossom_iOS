//
//  BaseTabbarTypeTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "BaseTableView.h"
#import "GlobleErrorView.h"
#import "BaseTableView+nodataShow.h"
#import "MJRefresh.h"
 
@interface BaseTableView() {

    NSString *reuseCellID;//重用cellID
}

@end


@implementation BaseTableView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initDataLogicModule];

    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initDataLogicModule];
    }
    return self;
}

-(void)_initDataLogicModule {
    self.dataLogicModule = [[TopbarTypeTableDataLogicModule alloc] init];
    self.noDataLogicModule = [[NodataLogicModule alloc] init];
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dataLogicModule = dataLogicModule;
    }
    return self;
}


-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
 
}

-(void)headerAutoRreshRequestBlock:(RequestDataBlock)headerAutoRequestBlock {
  
    self.dataLogicModule.isAutoHeaderFresh = YES;
    self.dataLogicModule.requestFromPage = 1;
    [self.mj_header beginRefreshing];
    if (headerAutoRequestBlock) {
        headerAutoRequestBlock();
    }
}

-(void)headerRreshRequestBlock:(RequestDataBlock)headerRequestBlock {
    __weak typeof(self) weak_self = self;
    //上下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        if (!weak_self.dataLogicModule.isAutoHeaderFresh) {//如果不是自动刷新
            weak_self.dataLogicModule.requestFromPage = 1;
            //重置nomoredata
            [weak_self.mj_footer resetNoMoreData];
            if (headerRequestBlock) {
//                weak_self.userInteractionEnabled = NO;//没刷新完不可以点击cell
                headerRequestBlock();
            }
        }
    }];
    self.mj_header = header;
    
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0f];
}

-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock {
//    self.userInteractionEnabled = NO;//没刷新完不可以点击cell
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        if (footerRequestBlock) {
     
            footerRequestBlock();
        }
    }];
    self.mj_footer = footer;
    footer.mj_h=30;
    footer.hidden = YES;//先隐藏不然一进页面就显示会很难看
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12.0f];
}


-(void)configureTableAfterRequestPagingData:(NSArray *)pagingDatas {

    if (isEmpty(pagingDatas)) {
        pagingDatas = @[];
    }
    
    if (self.dataLogicModule.currentDataModelArr.count>0) {
        if (pagingDatas.count==0) {//没有更多数据了就返回空，1页10条数据
                [self.mj_footer endRefreshingWithNoMoreData];
                
        }
        
    }

    //自动刷新
    if (self.dataLogicModule.isAutoHeaderFresh) {
        //标志完成自动刷新
        self.dataLogicModule.isFinishedHeaderAutoFresh = YES;
        self.dataLogicModule.isAutoHeaderFresh = NO;
        [self.mj_header endRefreshing];
      
    }
    
    
    
    //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
    if (self.dataLogicModule.requestFromPage == 1) {
        self.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:pagingDatas];
    }else {
        [self.dataLogicModule.currentDataModelArr addObjectsFromArray:pagingDatas];
    }
    
    
    if (self.noDataLogicModule.needDealNodataCondition) {
        [self nodataShowDeal];
    }
    
    if (pagingDatas.count<self.dataLogicModule.requestPageSize) {//判断最后一次数据是否小于10条的时候
        if (self.dataLogicModule.currentDataModelArr.count==0&&pagingDatas.count==0) {//0条数据
            if (self.noDataLogicModule.needDealNodataCondition) {
                [self nodataShowDeal];
 
                self.mj_footer.hidden = YES;
                [self.mj_header endRefreshing];
//                self.userInteractionEnabled = YES;
                return;
            }
            
 
        }else{
            [self.mj_header endRefreshing];
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = NO;
//            self.userInteractionEnabled = YES;
            [self reloadData];
            return;
        }
        
    }else {
        self.mj_footer.hidden = NO;
        [self.mj_footer endRefreshingWithNoMoreData];
    }

    //处理停止上下拉刷新逻辑
    if (self.dataLogicModule.requestFromPage == 1 && !self.dataLogicModule.isAutoHeaderFresh) {//下拉非自动刷新
        [self.mj_header endRefreshing];
    }else {//上拉加载更多
        [self.mj_footer endRefreshing];
    }
  
    
    [self reloadData];
    
    if (self.dataLogicModule.isRequestByPage) {
        self.dataLogicModule.requestFromPage ++;
    }
    
    if (pagingDatas.count < self.dataLogicModule.requestPageSize) {
        [self.mj_footer endRefreshingWithNoMoreData];
        self.mj_footer.hidden = NO;
    }else {
        self.mj_footer.hidden = NO;
        [self.mj_footer resetNoMoreData];
//        self.userInteractionEnabled = YES;
        return;
    }
//     self.userInteractionEnabled = YES;
    if (self.noDataLogicModule.needDealNodataCondition) {
        [self nodataShowDeal];
    }
}

-(void)configureTableAfterRequestTotalData:(NSArray *)tatalDatas {

    self.dataLogicModule.currentDataModelArr = [tatalDatas mutableCopy];
    [self reloadData];
    if (self.noDataLogicModule.needDealNodataCondition) {
        [self nodataShowDeal];
    }
}

- (void)dataEmptyHandle {
    [self nodataShowDeal];
}

- (void)closeHeaderFresh:(BOOL)closeHeaderFresh {
    self.mj_header.hidden = closeHeaderFresh;
}

- (void)closeFooterFresh:(BOOL)closeFooterFresh {
    self.mj_footer.hidden = closeFooterFresh;
}


 
 

@end
