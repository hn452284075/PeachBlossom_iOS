//
//  MycommonTableView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseTableView.h"

typedef void(^ConfigureCellBlock)(UITableView *tableView,id cellModel,UITableViewCell *cell,NSUInteger index);
typedef CGFloat(^CellHeightBlock)(UITableView *tableView,id cellModel);
typedef CGFloat(^TableSectionHeaderHeightBlock)(UITableView *tableView,NSInteger section);
typedef CGFloat(^TableSectionFooterHeightBlock)(UITableView *tableView,NSInteger section);
typedef void(^EditingCellBlock)(UITableView *tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *editingIndexPath, id cellModel);
typedef void(^ConfigureTablefirstSectionHeaderBlock)(UITableView *tableView,id cellModel,UIView *firstSectionHeaderView);
typedef void(^ConfigureTablefirstSectionFooterBlock)(UITableView *tableView,id cellModel,UIView *firstSectionFooterView);
typedef void(^ClickTableCellBlock)(UITableView *tableView,id cellModel,UITableViewCell *cell,NSIndexPath *clickIndexPath);
typedef void(^ListenTableViewScrollOffsetBlock)(CGFloat contentOffset);

@interface MycommonTableView : BaseTableView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)ConfigureCellBlock configurecellBlock;
//优先返回block高度，其次firstSectionHeaderHeight属性
@property (nonatomic,copy)TableSectionHeaderHeightBlock secontionHeaderHeightBlock;
@property (nonatomic,copy)TableSectionFooterHeightBlock secontionFooterHeightBlock;

//优先返回block高度，其次cellHeight属性
@property (nonatomic,copy)CellHeightBlock cellHeightBlock;

@property (nonatomic,copy)ConfigureTablefirstSectionHeaderBlock configurefirstSectionHeaderBlock;

@property (nonatomic,copy)ConfigureTablefirstSectionFooterBlock configureTablefirstSectionFooterBlock;

@property (nonatomic,copy)ClickTableCellBlock clickCellBlock;

@property (nonatomic,copy)EditingCellBlock editingCellBlock;

@property (nonatomic,copy)ListenTableViewScrollOffsetBlock listenTableViewScrollOffsetBlock;

/**
 *  默认UITableViewCellEditingStyleNone
 */
@property (nonatomic,assign)UITableViewCellEditingStyle editingStyle;

@property (nonatomic,copy)NSString *firstSectionHeaderNibName;
@property (nonatomic,copy)NSString *firstSectionHeaderViewName;
@property (nonatomic,copy)NSString *firstSectionHeaderIdentifer;
@property (nonatomic,assign)CGFloat firstSectionHeaderHeight;

@property (nonatomic,copy)NSString *firstSectionFooterNibName;
@property (nonatomic,copy)NSString *firstSectionFooterViewName;
@property (nonatomic,copy)NSString *firstSectionFooterIdentifer;
@property (nonatomic,assign)CGFloat firstSectionFooterHeight;

@property (nonatomic,copy)NSString *cellNibName;
@property (nonatomic,copy)NSString *cellIdentifer;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIView *footerView;

#pragma mark - 配置firstSectionHeader
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
         ConfigureTablefirstSectionHeaderBlock:(ConfigureTablefirstSectionHeaderBlock)configurefirstSectionHeaderBlock;
//非XIB
- (void)configureFirstSectioHeaderViewName:(NSString *)firstSectionHeaderViewName
                          SectioHeaderView:(UIView *)headView
     ConfigureTablefirstSectionHeaderBlock:(ConfigureTablefirstSectionHeaderBlock)configurefirstSectionHeaderBlock;

#pragma mark - 配置firstSectionFooter
- (void)configureFirstSectioFooterNibName:(NSString *)firstSectionFooterNibName
    ConfigureTablefirstSectionFooterBlock:(ConfigureTablefirstSectionFooterBlock)configurefirstSectionFooterBlock;

//非XIB
- (void)configureFirstSectioFooterViewName:(NSString *)firstSectionFooterViewName
                         SectioFooterView:(UIView *)footerView
    ConfigureTablefirstSectionFooterBlock:(ConfigureTablefirstSectionFooterBlock)configurefirstSectionFooterBlock;

#warning 这三个方法必须要调用其中一个
/** 没有cell点击方法的表 */
 
-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(ConfigureCellBlock)configurecellBlock;
/**带cell点击方法的表  */
-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(ConfigureCellBlock)configurecellBlock
                            clickCell:(ClickTableCellBlock)clickCellBlock;
/** 带数据源以及cell点击方法的表 */
-(void)configurecellNibName:(NSString *)cellNibName
                       cellDataSource:(NSArray *)cellDataSource
          configurecellData:(ConfigureCellBlock)configurecellBlock
                            clickCell:(ClickTableCellBlock)clickCellBlock;

-(void)configurecellNibClassName:(Class)cellClassName
          forCellReuseIdentifier:(NSString *)identifier
                  cellDataSource:(NSArray *)cellDataSource
               configurecellData:(ConfigureCellBlock)configurecellBlock
                       clickCell:(ClickTableCellBlock)clickCellBlock;

@end
